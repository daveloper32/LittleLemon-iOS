//
//  TestyView.swift
//  LittleLemon
//
//  Created by David Esteban Hernández Garzón on 19/04/23.
//

import SwiftUI

struct TestyView: View {
    @Environment(\.managedObjectContext) private var viewContext
    private let homeViewModel: HomeViewModel = HomeViewModel()
    var body: some View {
        FetchedObjects { (dishes: [Dish]) in
            List {
                ForEach(dishes, id: \.self) { dish in
                    ProductDetailsView(dish: dish)
                }
            }
        }.task {
            await homeViewModel.getMenuData(context: viewContext)
        }
    }
}

struct TestyView_Previews: PreviewProvider {
    static var previews: some View {
        TestyView()
    }
}
