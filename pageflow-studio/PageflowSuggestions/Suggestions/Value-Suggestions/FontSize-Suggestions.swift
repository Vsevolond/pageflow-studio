//
//  FontSize-Suggestions.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 21.02.2026.
//

import SwiftUI
import Foundation

extension PageflowSuggestions.Values {
    
    // MARK: - FontSize Suggestions
    
    enum FontSize {
        
        static var tiny: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "tiny",
                detail: "Крошечный",
                image: Image(systemName: "f.square.fill"),
                imageColor: .blue,
                insertText: "tiny"
            )
        }
        
        static var script: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "script",
                detail: "Скриптовый",
                image: Image(systemName: "f.square.fill"),
                imageColor: .blue,
                insertText: "script"
            )
        }
        
        static var footnote: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "footnote",
                detail: "Вспомогательный",
                image: Image(systemName: "f.square.fill"),
                imageColor: .blue,
                insertText: "footnote"
            )
        }
        
        static var small: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "small",
                detail: "Мелкий",
                image: Image(systemName: "f.square.fill"),
                imageColor: .blue,
                insertText: "small"
            )
        }
        
        static var normal: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "normal",
                detail: "Обычный",
                image: Image(systemName: "f.square.fill"),
                imageColor: .blue,
                insertText: "normal"
            )
        }
        
        static var large: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "large",
                detail: "Крупный",
                image: Image(systemName: "f.square.fill"),
                imageColor: .blue,
                insertText: "large"
            )
        }
        
        static var larger: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "larger",
                detail: "Более крупный",
                image: Image(systemName: "f.square.fill"),
                imageColor: .blue,
                insertText: "larger"
            )
        }
        
        static var largest: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "largest",
                detail: "Самый крупный",
                image: Image(systemName: "f.square.fill"),
                imageColor: .blue,
                insertText: "largest"
            )
        }
        
        static var huge: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "huge",
                detail: "Огромный",
                image: Image(systemName: "f.square.fill"),
                imageColor: .blue,
                insertText: "huge"
            )
        }
        
        static var hugest: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "hugest",
                detail: "Громадный",
                image: Image(systemName: "f.square.fill"),
                imageColor: .blue,
                insertText: "hugest"
            )
        }
    }
}
