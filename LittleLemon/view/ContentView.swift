//
//  ContentView.swift
//  LittleLemon
//
//  Created by David Esteban Hernández Garzón on 17/04/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    private var manager: LittleLemonUserDefaultsManager = LittleLemonUserDefaultsManager()
    @State private var navigateToHomeView: Bool = false
    var body: some View {
        VStack {
            if (manager.userIsLoggedIn()) { // If user is already logged in / registered load the Home View
                HomeView().navigationBarHidden(true)
            } else {
                NavigationView {
                    OnBoardingView(
                        onRegisterSucess: {
                            navigateToHomeView = true
                        }
                    ).background(
                        NavigationLink(
                            destination: HomeView(),
                            isActive: $navigateToHomeView,
                            label: { EmptyView() }
                        )
                    )
                    .navigationBarHidden(true)
                }
            }
        }.navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
