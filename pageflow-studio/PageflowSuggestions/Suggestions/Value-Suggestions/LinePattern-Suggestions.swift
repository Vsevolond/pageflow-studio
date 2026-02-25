//
//  LinePattern-Suggestions.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 21.02.2026.
//

import SwiftUI
import Foundation

extension PageflowSuggestions.Values {
    
    // MARK: - LinePattern Suggestions
    
    enum LinePattern {
        
        static var dash: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "dash",
                detail: "Тире",
                image: Image(systemName: "p.square.fill"),
                imageColor: .blue,
                insertText: "dash"
            )
        }
        
        static var dashDot: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "dashDot",
                detail: "Тире - точка",
                image: Image(systemName: "p.square.fill"),
                imageColor: .blue,
                insertText: "dashDot"
            )
        }
        
        static var dashDotDot: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "dashDotDot",
                detail: "Тире - точка - точка",
                image: Image(systemName: "p.square.fill"),
                imageColor: .blue,
                insertText: "dashDotDot"
            )
        }
        
        static var dot: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "dot",
                detail: "Точка",
                image: Image(systemName: "p.square.fill"),
                imageColor: .blue,
                insertText: "dot"
            )
        }
        
        static var solid: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "solid",
                detail: "Сплошная линия",
                image: Image(systemName: "p.square.fill"),
                imageColor: .blue,
                insertText: "solid"
            )
        }
    }
}
