//
//  Boolean-Suggestions.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 21.02.2026.
//

import SwiftUI

extension PageflowSuggestions {
    
    // MARK: - Boolean Suggestions
    
    enum Booleans {
        
        static var `true`: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "true",
                image: Image(systemName: "b.square.fill"),
                imageColor: .blue,
                insertText: "true"
            )
        }
        
        static var `false`: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "false",
                image: Image(systemName: "b.square.fill"),
                imageColor: .blue,
                insertText: "false"
            )
        }
    }
}
