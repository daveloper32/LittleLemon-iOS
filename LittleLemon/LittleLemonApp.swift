//
//  LittleLemonApp.swift
//  LittleLemon
//
//  Created by David Esteban Hernández Garzón on 17/04/23.
//

import SwiftUI

@main
struct LittleLemonApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
