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
            if let url = Bundle.main.resourceURL {
                ContentView(queriesURL: url)
            }
        }
    }
}
