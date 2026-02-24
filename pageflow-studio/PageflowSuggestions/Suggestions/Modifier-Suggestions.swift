//
//  Modifier-Suggestions.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 21.02.2026.
//

import SwiftUI
import Foundation

extension PageflowSuggestions {
    
    // MARK: - Modifier Suggestions
    
    enum Modifiers {
        
        static var vAlignment: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "alignment",
                detail: "Горизонтальное выравнивание элементов",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "alignment(HorizontalAlignment)",
                cursorOffset: 1
            )
        }
        
        static var hAlignment: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "alignment",
                detail: "Вертикальное выравнивание элементов",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "alignment(VerticalAlignment)",
                cursorOffset: 1
            )
        }
        
        static var zAlignment: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "alignment",
                detail: "Выравнивание элементов",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "alignment(Alignment)",
                cursorOffset: 1
            )
        }
        
        static var header: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "header",
                detail: "Верхний колонтитул",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "header(\"\")",
                cursorOffset: 2
            )
        }
        
        static var footer: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "footer",
                detail: "Нижний колонтитул",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "footer(\"\")",
                cursorOffset: 2
            )
        }
        
        static var width: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "width",
                detail: "Ширина",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "width()",
                cursorOffset: 1
            )
        }
        
        static var height: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "height",
                detail: "Высота",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "height()",
                cursorOffset: 1
            )
        }
        
        static var layout: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "layout",
                detail: "Расположение",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "layout(Alignment)",
                cursorOffset: 1
            )
        }
        
        static var padding: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "padding",
                detail: "Внешний отступ от элементов",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "padding(Edge, )",
                cursorOffset: 3
            )
        }
        
        static var offset: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "padding",
                detail: "Смещение по оси",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "offset(Axis, )",
                cursorOffset: 3
            )
        }
        
        static var margin: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "margin",
                detail: "Внутренний отступ элементов от краев",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "margin(Edge, )",
                cursorOffset: 3
            )
        }
        
        static var enumerated: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "enumerated",
                detail: "Нумерация (по умолчанию - false)",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "enumerated()",
                cursorOffset: 1
            )
        }
        
        static var caption: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "caption",
                detail: "Подпись",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "caption(\"\")",
                cursorOffset: 2
            )
        }
        
        static var subfigure: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "caption",
                detail: "Подфигура (по умолчанию - false)",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "subfigure()",
                cursorOffset: 1
            )
        }
        
        static var spacing: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "spacing",
                detail: "Отступ между элементами",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "spacing()",
                cursorOffset: 1
            )
        }
        
        static var tint: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "tint",
                detail: "Цвет элемента",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "tint(Color)",
                cursorOffset: 1
            )
        }
        
        static var background: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "background",
                detail: "Цвет фона",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "background(Color)",
                cursorOffset: 1
            )
        }
        
        static var textAlignment: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "textAlignment",
                detail: "Выравнивание текста",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "textAlignment(HorizontalAlignment)",
                cursorOffset: 1
            )
        }
        
        static var lineSpacing: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "lineSpacing",
                detail: "Межстрочный интервал",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "lineSpacing()",
                cursorOffset: 1
            )
        }
        
        static var underline: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "underline",
                detail: "Подчеркивание",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "underline(LinePattern, Color)",
                cursorOffset: 8
            )
        }
        
        static var strikethrough: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "strikethrough",
                detail: "Зачеркивание",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "strikethrough(LinePattern, Color)",
                cursorOffset: 8
            )
        }
        
        static var fontSize: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "fontSize",
                detail: "Размер шрифта",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "fontSize(FontSize)",
                cursorOffset: 1
            )
        }
        
        static var fontStyle: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "fontStyle",
                detail: "Стиль шрифта",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "fontStyle(FontStyle)",
                cursorOffset: 1
            )
        }
        
        static var codeLanguage: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "language",
                detail: "Язык программирования",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "language(CodeLanguage)",
                cursorOffset: 1
            )
        }
        
        static var codeStyle: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "style",
                detail: "Стиль подсветки",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "style(CodeStyle)",
                cursorOffset: 1
            )
        }
        
        static var codeFrame: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "frame",
                detail: "Рамка",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "frame(CodeFrame)",
                cursorOffset: 1
            )
        }
        
        static var codeNumbers: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "numbers",
                detail: "Нумерация строк (по умолчанию - true)",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "numbers()",
                cursorOffset: 1
            )
        }
    }
}
