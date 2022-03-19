//
//  WordleApp.swift
//  Wordle
//
//  Created by Anthony Bajoua on 3/19/22.
//

import SwiftUI

@main
struct WordleApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
