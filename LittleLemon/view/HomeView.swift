//
//  HomeView.swift
//  LittleLemon
//
//  Created by David Esteban Hernández Garzón on 18/04/23.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var navigateToProfileView: Bool = false
    @State private var filterTextValue: String = ""
    @State private var categorySelected: String = "all"
    private let homeViewModel: HomeViewModel = HomeViewModel()
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                LittleLemonToolbar(
                    onProfilePhotoClicked: {
                        navigateToProfileView = true
                    }
                )
                ScrollView {
                    HeroHomeView(filterTextValue: $filterTextValue)
                    ChipsContainer { value in
                        print("onChipClicked (\(value), currentValue: \(categorySelected)")
                        categorySelected = value
                    }
                    FetchedObjects(
                        predicate:buildPredicate(),
                        sortDescriptors: buildSortDescriptors()
                    ) { (dishes: [Dish]) in
                        ForEach(dishes, id: \.self) { dish in
                            ProductDetailsView(dish: dish)
                        }
                    }
                }.task {
                    await homeViewModel.getMenuData(context: viewContext)
                }
            }.navigationBarHidden(true)
            .background(
                NavigationLink(
                    destination: ProfileView(),
                    isActive: $navigateToProfileView,
                    label: { EmptyView() }
                )
            )
        }.navigationBarHidden(true)
    }
    func buildPredicate() -> NSPredicate {
        if filterTextValue == "" {
            if categorySelected != "all" {
                return NSPredicate(format: "category == %@", categorySelected)
            } else {
                return NSPredicate(value: true)
            }
        }
        if (categorySelected == "all") {
            return NSPredicate(format: "title CONTAINS[cd] %@", filterTextValue)
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@ AND category == %@", filterTextValue, categorySelected)
        }
    }
    
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [
            NSSortDescriptor(
                 key: "title",
                 ascending: true,
                 selector: #selector(NSString .localizedCaseInsensitiveCompare))
            
        ]
    }
}

private struct LittleLemonToolbar: View {
    var onProfilePhotoClicked: () -> Void
    var body: some View {
        ZStack(alignment: .trailing) {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200)
                .frame(maxWidth: .infinity)
            Button {
                onProfilePhotoClicked()
            } label: {
                Image("profile")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 45)
            }.padding(.trailing, 12)
        }.padding(.vertical, 20)
            .frame(maxWidth: .infinity)
    }
}

private struct HeroHomeView: View {
    @Binding var filterTextValue: String
    var body: some View {
        ZStack {
            LittleLemonColors().Primary
            VStack(alignment: .leading, spacing: 0) {
                Text(
                    NSLocalizedString("title", comment: "")
                ).font(
                    .custom(
                        LittleLemonFonts().markaziTextRegularFont,
                        size: 48
                    )
                ).foregroundColor(LittleLemonColors().Secondary)
                Text(
                    NSLocalizedString("location", comment: "")
                ).font(
                    .custom(
                        LittleLemonFonts().markaziTextRegularFont,
                        size: 36
                    )
                ).foregroundColor(LittleLemonColors().White)
                HStack(spacing: 0) {
                    Text(
                        NSLocalizedString("description", comment: "")
                    ).font(
                        .custom(
                            LittleLemonFonts().karlaRegularFont,
                            size: 16
                        )
                    ).foregroundColor(LittleLemonColors().White)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.trailing, 16)
                    Image("hero_image")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width * 0.4, height: 140)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.bottom, 8)
                VStack {
                    HStack {
                        Image(
                            systemName: "magnifyingglass"
                        ).foregroundColor(.gray)
                            .padding(.trailing, 10)
                        TextField(
                            "Enter search phrase",
                            text: $filterTextValue
                        )
                    }.padding()
                }.background(Color.white.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.top, 8)
                    .padding(.bottom, 8)
            }.padding(16)
        }
    }
}

private struct ChipsContainer: View {
    let onChipClicked: (String) -> Void
    var body: some View {
        VStack {
            Text(
                NSLocalizedString("lab_order_for_delivery", comment: "").uppercased()
            ).font(
                .custom(
                    LittleLemonFonts().karlaRegularFont,
                    size: 24
                )
            )
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 16)
                .padding(.horizontal, 16)
            ScrollView(.horizontal) {
                HStack(spacing: 1) {
                    ChipCustom(
                        name: NSLocalizedString("lab_all", comment: "")
                    ) { value in
                        onChipClicked(value.lowercased())
                    }
                    ChipCustom(
                        name: NSLocalizedString("lab_starters", comment: "")
                    ) { value in
                        onChipClicked(value.lowercased())
                    }
                    ChipCustom(
                        name: NSLocalizedString("lab_mains", comment: "")
                    ) { value in
                        onChipClicked(value.lowercased())
                    }
                    ChipCustom(
                        name: NSLocalizedString("lab_desserts", comment: "")
                    ) { value in
                        onChipClicked(value.lowercased())
                    }
                    ChipCustom(
                        name: NSLocalizedString("lab_sides", comment: "")
                    ) { value in
                        onChipClicked(value.lowercased())
                    }
                }
            }
            .padding(.bottom, 16)
            .padding(.horizontal, 16)
            Rectangle()
                .fill(LittleLemonColors().GrayTransparent.opacity(0.5))
                .frame(maxWidth: .infinity, maxHeight: 1)
        }
    }
}

private struct ChipCustom: View {
    let name: String
    let onChipClicked: (String) -> Void

    var body: some View {
        Button(action: {
            onChipClicked(name)
        }, label: {
            Text(name)
                .font(
                    .custom(
                        LittleLemonFonts().karlaRegularFont,
                        size: 16
                    )
                )
                .foregroundColor(LittleLemonColors().Primary)
                .padding()
                .background(LittleLemonColors().GrayLight)
                .cornerRadius(16)
        })
        .padding(.trailing, 16)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
