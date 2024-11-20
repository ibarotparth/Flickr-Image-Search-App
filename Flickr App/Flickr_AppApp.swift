//
//  Flickr_AppApp.swift
//  Flickr App
//
//  Created by Parth Barot on 11/19/24.
//

import SwiftUI

struct Flickr_AppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
