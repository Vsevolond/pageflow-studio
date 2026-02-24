//
//  FontStyle-Suggestions.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 21.02.2026.
//

import SwiftUI
import Foundation

extension PageflowSuggestions.Values {
    
    // MARK: - FontStyle Suggestions
    
    enum FontStyle {
        
        static var medium: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "medium",
                detail: "Обычный",
                image: Image(systemName: "f.square.fill"),
                imageColor: .blue,
                insertText: "medium"
            )
        }
        
        static var bold: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "bold",
                detail: "Полужирный",
                image: Image(systemName: "f.square.fill"),
                imageColor: .blue,
                insertText: "bold"
            )
        }
        
        static var italic: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "italic",
                detail: "Курсивный",
                image: Image(systemName: "f.square.fill"),
                imageColor: .blue,
                insertText: "italic"
            )
        }
        
        static var monospaced: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "monospaced",
                detail: "Моноширинный",
                image: Image(systemName: "f.square.fill"),
                imageColor: .blue,
                insertText: "monospaced"
            )
        }
        
        static var smallCaps: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "smallCaps",
                detail: "Капитель",
                image: Image(systemName: "f.square.fill"),
                imageColor: .blue,
                insertText: "smallCaps"
            )
        }
    }
}
