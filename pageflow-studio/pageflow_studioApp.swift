//
//  pageflow_studioApp.swift
//  pageflow-studio
//
//  Created by Всеволод Донченко on 11.11.2025.
//

import SwiftUI

@main
struct pageflow_studioApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .commands {
            CommandMenu("Insert") {
                Button("Add Image...") {
                    NotificationCenter.default.post(name: .requestImageImport, object: nil)
                }
                .keyboardShortcut("i", modifiers: .command)
                
                Button("Add Listing...") {
                    NotificationCenter.default.post(name: .requestListingAdd, object: nil)
                }
                .keyboardShortcut("l", modifiers: .command)
            }
        }
    }
}

extension Notification.Name {
    static let requestImageImport = Notification.Name("requestImageImport")
    static let requestListingAdd = Notification.Name("requestListingAdd")
}
