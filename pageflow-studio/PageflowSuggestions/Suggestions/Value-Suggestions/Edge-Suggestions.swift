//
//  Edge-Suggestions.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 21.02.2026.
//

import SwiftUI
import Foundation

extension PageflowSuggestions.Values {
    
    // MARK: - Edge Suggestions
    
    enum Edge {
        
        static var top: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "top",
                detail: "Сверху",
                image: Image(systemName: "e.square.fill"),
                imageColor: .blue,
                insertText: "top"
            )
        }
        
        static var bottom: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "bottom",
                detail: "Снизу",
                image: Image(systemName: "e.square.fill"),
                imageColor: .blue,
                insertText: "bottom"
            )
        }
        
        static var leading: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "leading",
                detail: "Слева",
                image: Image(systemName: "e.square.fill"),
                imageColor: .blue,
                insertText: "leading"
            )
        }
        
        static var trailing: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "trailing",
                detail: "Справа",
                image: Image(systemName: "e.square.fill"),
                imageColor: .blue,
                insertText: "trailing"
            )
        }
        
        static var all: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "all",
                detail: "Со всех сторон",
                image: Image(systemName: "e.square.fill"),
                imageColor: .blue,
                insertText: "all"
            )
        }
    }
}
