//
//  Constant-Suggestions.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 21.02.2026.
//

import SwiftUI

extension PageflowSuggestions {
    
    // MARK: - Constant Suggestions
    
    enum Constants {
        
        static var width: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "width",
                detail: "Ширина страницы",
                image: Image(systemName: "c.square.fill"),
                imageColor: .blue,
                insertText: "width"
            )
        }
        
        static var height: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "height",
                detail: "Высота страницы",
                image: Image(systemName: "c.square.fill"),
                imageColor: .blue,
                insertText: "height"
            )
        }
    }
}
