//
//  BasicSwiftApp.swift
//  BasicSwift
//
//  Created by remotestate on 13/03/23.
//

import SwiftUI

@main
struct BasicSwiftApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
