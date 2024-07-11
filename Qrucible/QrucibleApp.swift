//
//  QrucibleApp.swift
//  Qrucible
//
//  Created by Rehan Khan on 11/07/2024.
//

import SwiftUI

@main
struct QrucibleApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
