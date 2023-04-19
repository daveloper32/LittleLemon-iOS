//
//  HomeView.swift
//  LittleLemon
//
//  Created by David Esteban Hernández Garzón on 18/04/23.
//

import SwiftUI

struct HomeView: View {
    @State private var navigateToProfileView: Bool = false
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    LittleLemonToolbar(
                        onProfilePhotoClicked: {
                            navigateToProfileView = true
                        }
                    )
                    HeroHomeView()
                }.background(
                    NavigationLink(
                        destination: ProfileView(),
                        isActive: $navigateToProfileView,
                        label: { EmptyView() }
                    )
                )
            } .navigationBarHidden(true)
        }.navigationBarHidden(true)
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
            }.padding(16)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
