//
//  Color-Suggestions.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 21.02.2026.
//

import SwiftUI
import Foundation
import PageflowSourceEditor

extension PageflowSuggestions.Values {
    
    // MARK: - Color Suggestions
    
    enum Color {
        
        static var red: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "red",
                detail: "Красный",
                image: Image(systemName: "c.square.fill"),
                imageColor: .init(hex: "EA3323"),
                insertText: "red"
            )
        }
        
        static var green: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "green",
                detail: "Зеленый",
                image: Image(systemName: "c.square.fill"),
                imageColor: .init(hex: "75FB4C"),
                insertText: "green"
            )
        }
        
        static var blue: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "blue",
                detail: "Синий",
                image: Image(systemName: "c.square.fill"),
                imageColor: .init(hex: "0600F5"),
                insertText: "blue"
            )
        }
        
        static var cyan: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "cyan",
                detail: "Голубой",
                image: Image(systemName: "c.square.fill"),
                imageColor: .init(hex: "48A0D5"),
                insertText: "cyan"
            )
        }
        
        static var magenta: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "magenta",
                detail: "Малиновый",
                image: Image(systemName: "c.square.fill"),
                imageColor: .init(hex: "C62F7C"),
                insertText: "magenta"
            )
        }
        
        static var yellow: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "yellow",
                detail: "Желтый",
                image: Image(systemName: "c.square.fill"),
                imageColor: .init(hex: "FDF150"),
                insertText: "yellow"
            )
        }
        
        static var black: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "black",
                detail: "Черный",
                image: Image(systemName: "c.square.fill"),
                imageColor: .init(hex: "000000"),
                insertText: "black"
            )
        }
        
        static var gray: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "gray",
                detail: "Серый",
                image: Image(systemName: "c.square.fill"),
                imageColor: .init(hex: "808080"),
                insertText: "gray"
            )
        }
        
        static var white: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "white",
                detail: "Белый",
                image: Image(systemName: "c.square.fill"),
                imageColor: .init(hex: "FFFFFF"),
                insertText: "white"
            )
        }
        
        static var darkGray: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "darkGray",
                detail: "Темный серый",
                image: Image(systemName: "c.square.fill"),
                imageColor: .init(hex: "404040"),
                insertText: "darkGray"
            )
        }
        
        static var lightGray: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "lightGray",
                detail: "Светлый серый",
                image: Image(systemName: "c.square.fill"),
                imageColor: .init(hex: "BFBFBF"),
                insertText: "lightGray"
            )
        }
        
        static var brown: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "brown",
                detail: "Коричневый",
                image: Image(systemName: "c.square.fill"),
                imageColor: .init(hex: "B6824B"),
                insertText: "brown"
            )
        }
        
        static var lime: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "lime",
                detail: "Лаймовый",
                image: Image(systemName: "c.square.fill"),
                imageColor: .init(hex: "CCFD51"),
                insertText: "lime"
            )
        }
        
        static var olive: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "olive",
                detail: "Оливковый",
                image: Image(systemName: "c.square.fill"),
                imageColor: .init(hex: "87832F"),
                insertText: "olive"
            )
        }
        
        static var orange: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "orange",
                detail: "Оранжевый",
                image: Image(systemName: "c.square.fill"),
                imageColor: .init(hex: "EF8733"),
                insertText: "orange"
            )
        }
        
        static var pink: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "pink",
                detail: "Розовый",
                image: Image(systemName: "c.square.fill"),
                imageColor: .init(hex: "F5C1C0"),
                insertText: "pink"
            )
        }
        
        static var purple: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "purple",
                detail: "Багровый",
                image: Image(systemName: "c.square.fill"),
                imageColor: .init(hex: "AF2343"),
                insertText: "purple"
            )
        }
        
        static var teal: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "teal",
                detail: "Бирюзовый",
                image: Image(systemName: "c.square.fill"),
                imageColor: .init(hex: "377E7F"),
                insertText: "teal"
            )
        }
        
        static var violet: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "violet",
                detail: "Фиолетовый",
                image: Image(systemName: "c.square.fill"),
                imageColor: .init(hex: "75157C"),
                insertText: "violet"
            )
        }
    }
}
