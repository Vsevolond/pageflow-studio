//
//  Axis-Suggestions.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 21.02.2026.
//

import SwiftUI

extension PageflowSuggestions.Values {
    
    // MARK: - Axis Suggestions
    
    enum Axis {
        
        static var vertical: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "vertical",
                detail: "Вертикальная ось",
                image: Image(systemName: "a.square.fill"),
                imageColor: .blue,
                insertText: "vertical"
            )
        }
        
        static var horizontal: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "horizontal",
                detail: "Горизонтальная ось",
                image: Image(systemName: "a.square.fill"),
                imageColor: .blue,
                insertText: "horizontal"
            )
        }
    }
}
