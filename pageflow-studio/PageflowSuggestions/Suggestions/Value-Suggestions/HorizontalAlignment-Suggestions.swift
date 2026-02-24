//
//  HorizontalAlignment-Suggestions.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 21.02.2026.
//

import SwiftUI
import Foundation

extension PageflowSuggestions.Values {
    
    // MARK: - HorizontalAlignment Suggestions
    
    enum HorizontalAlignment {
        
        static var center: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "center",
                detail: "По центру",
                image: Image(systemName: "h.square.fill"),
                imageColor: .blue,
                insertText: "center"
            )
        }
        
        static var leading: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "leading",
                detail: "По левой стороне",
                image: Image(systemName: "h.square.fill"),
                imageColor: .blue,
                insertText: "leading"
            )
        }
        
        static var trailing: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "trailing",
                detail: "По правой стороне",
                image: Image(systemName: "h.square.fill"),
                imageColor: .blue,
                insertText: "trailing"
            )
        }
    }
}
