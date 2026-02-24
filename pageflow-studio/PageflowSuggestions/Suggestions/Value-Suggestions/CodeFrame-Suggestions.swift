//
//  CodeFrame-Suggestions.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 21.02.2026.
//

import SwiftUI
import Foundation

extension PageflowSuggestions.Values {
    
    // MARK: - CodeFrame Suggestions
    
    enum CodeFrame {
        
        static var lefline: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "lefline",
                image: Image(systemName: "f.square.fill"),
                imageColor: .blue,
                insertText: "lefline"
            )
        }
        
        static var topline: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "topline",
                image: Image(systemName: "f.square.fill"),
                imageColor: .blue,
                insertText: "topline"
            )
        }
        
        static var bottomline: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "bottomline",
                image: Image(systemName: "f.square.fill"),
                imageColor: .blue,
                insertText: "bottomline"
            )
        }
        
        static var lines: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "lines",
                image: Image(systemName: "f.square.fill"),
                imageColor: .blue,
                insertText: "lines"
            )
        }
        
        static var single: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "single",
                image: Image(systemName: "f.square.fill"),
                imageColor: .blue,
                insertText: "single"
            )
        }
    }
}
