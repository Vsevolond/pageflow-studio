//
//  Type-Suggestions.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 21.02.2026.
//

import SwiftUI
import Foundation

extension PageflowSuggestions {
    
    // MARK: - Type Suggestions
    
    enum Types {
        
        static var horizontalAlignment: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "HorizontalAlignment",
                detail: "Горизонтальное выравнивание",
                image: Image(systemName: "t.square.fill"),
                imageColor: .purple,
                insertText: "HorizontalAlignment"
            )
        }
        
        static var verticalAlignment: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "VerticalAlignment",
                detail: "Вертикальное выравнивание",
                image: Image(systemName: "t.square.fill"),
                imageColor: .purple,
                insertText: "VerticalAlignment"
            )
        }
        
        static var alignment: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "Alignment",
                detail: "Выравнивание",
                image: Image(systemName: "t.square.fill"),
                imageColor: .purple,
                insertText: "Alignment"
            )
        }
        
        static var edge: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "Edge",
                detail: "Сторона",
                image: Image(systemName: "t.square.fill"),
                imageColor: .purple,
                insertText: "Edge"
            )
        }
        
        static var axis: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "Axis",
                detail: "Ось",
                image: Image(systemName: "t.square.fill"),
                imageColor: .purple,
                insertText: "Axis"
            )
        }
        
        static var color: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "Color",
                detail: "Цвет",
                image: Image(systemName: "t.square.fill"),
                imageColor: .purple,
                insertText: "Color"
            )
        }
        
        static var linePattern: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "LinePattern",
                detail: "Узор линии",
                image: Image(systemName: "t.square.fill"),
                imageColor: .purple,
                insertText: "LinePattern"
            )
        }
        
        static var fontSize: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "FontSize",
                detail: "Размер шрифта",
                image: Image(systemName: "t.square.fill"),
                imageColor: .purple,
                insertText: "FontSize"
            )
        }
        
        static var fontStyle: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "FontStyle",
                detail: "Стиль шрифта",
                image: Image(systemName: "t.square.fill"),
                imageColor: .purple,
                insertText: "FontStyle"
            )
        }
        
        static var codeLanguage: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "CodeLanguage",
                detail: "Язык программирования",
                image: Image(systemName: "t.square.fill"),
                imageColor: .purple,
                insertText: "CodeLanguage"
            )
        }
        
        static var codeStyle: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "CodeStyle",
                detail: "Стиль подсветки",
                image: Image(systemName: "t.square.fill"),
                imageColor: .purple,
                insertText: "CodeStyle"
            )
        }
        
        static var codeFrame: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "CodeFrame",
                detail: "Рамка",
                image: Image(systemName: "t.square.fill"),
                imageColor: .purple,
                insertText: "CodeFrame"
            )
        }
    }
}
