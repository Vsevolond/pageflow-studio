//
//  Block-Suggestions.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 21.02.2026.
//

import SwiftUI

extension PageflowSuggestions {
    
    // MARK: - Block Suggestions
    
    enum Blocks {
        
        static var newPage: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "NewPage",
                detail: "Новая страница",
                image: Image(systemName: "b.square.fill"),
                imageColor: .purple,
                insertText: "NewPage {}",
                cursorOffset: 1
            )
        }
        
        static var section: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "Section",
                detail: "Раздел с заголовком",
                image: Image(systemName: "b.square.fill"),
                imageColor: .purple,
                insertText: "Section(\"\") {}",
                cursorOffset: 5
            )
        }
        
        static var subSection: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "SubSection",
                detail: "Подраздел с заголовком",
                image: Image(systemName: "b.square.fill"),
                imageColor: .purple,
                insertText: "SubSection(\"\") {}",
                cursorOffset: 5
            )
        }
        
        static var vStack: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "VStack",
                detail: "Вертикальный стек",
                image: Image(systemName: "b.square.fill"),
                imageColor: .purple,
                insertText: "VStack {}",
                cursorOffset: 1
            )
        }
        
        static var hStack: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "HStack",
                detail: "Горизонтальный стек",
                image: Image(systemName: "b.square.fill"),
                imageColor: .purple,
                insertText: "HStack {}",
                cursorOffset: 1
            )
        }
        
        static var zStack: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "ZStack",
                detail: "Стек глубины",
                image: Image(systemName: "b.square.fill"),
                imageColor: .purple,
                insertText: "ZStack {}",
                cursorOffset: 1
            )
        }
        
        static var text: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "Text",
                detail: "Текстовый блок",
                image: Image(systemName: "b.square.fill"),
                imageColor: .purple,
                insertText: "Text {}",
                cursorOffset: 1
            )
        }
        
        static var math: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "Math",
                detail: "Математический блок",
                image: Image(systemName: "b.square.fill"),
                imageColor: .purple,
                insertText: "Math {}",
                cursorOffset: 1
            )
        }
        
        static var image: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "Image",
                detail: "Изображение",
                image: Image(systemName: "b.square.fill"),
                imageColor: .purple,
                insertText: "Image()",
                cursorOffset: 1
            )
        }
        
        static var listing: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "Listing",
                detail: "Листинг кода",
                image: Image(systemName: "b.square.fill"),
                imageColor: .purple,
                insertText: "Listing()",
                cursorOffset: 1
            )
        }
        
        static var spacer: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "Spacer",
                detail: "Заполнитель пространства",
                image: Image(systemName: "b.square.fill"),
                imageColor: .purple,
                insertText: "Spacer()",
                cursorOffset: 1
            )
        }
        
        static var divider: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "Divider",
                detail: "Разделительная линия",
                image: Image(systemName: "b.square.fill"),
                imageColor: .purple,
                insertText: "Divider()",
                cursorOffset: 1
            )
        }
    }
}
