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
                insertText: "alignment()",
                cursorOffset: 1
            )
        }
        
        static var hAlignment: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "alignment",
                detail: "Вертикальное выравнивание элементов",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "alignment()",
                cursorOffset: 1
            )
        }
        
        static var zAlignment: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "alignment",
                detail: "Выравнивание элементов",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "alignment()",
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
                insertText: "layout()",
                cursorOffset: 1
            )
        }
        
        static var padding: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "padding",
                detail: "Внешний отступ от элементов (по умолчанию - all)",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "padding()",
                cursorOffset: 1
            )
        }
        
        static var paddingTop: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "padding",
                detail: "Внешний отступ от элементов сверху",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "padding(, .top)",
                cursorOffset: 7
            )
        }
        
        static var paddingBottom: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "padding",
                detail: "Внешний отступ от элементов снизу",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "padding(, .bottom)",
                cursorOffset: 10
            )
        }
        
        static var paddingLeading: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "padding",
                detail: "Внешний отступ от элементов слева",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "padding(, .leading)",
                cursorOffset: 11
            )
        }
        
        static var paddingTrailing: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "padding",
                detail: "Внешний отступ от элементов справа",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "padding(, .trailing)",
                cursorOffset: 12
            )
        }
        
        static var offset: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "offset",
                detail: "Смещение по оси (по умолчанию - horizontal)",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "offset()",
                cursorOffset: 1
            )
        }
        
        static var offsetVertical: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "offset",
                detail: "Смещение по вертикальной оси",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "offset(, .vertical)",
                cursorOffset: 12
            )
        }
        
        static var margin: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "margin",
                detail: "Внутренний отступ элементов от краев (по умолчанию - all)",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "margin()",
                cursorOffset: 1
            )
        }
        
        static var marginTop: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "margin",
                detail: "Внутренний отступ элементов от верхнего края",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "margin(, .top)",
                cursorOffset: 7
            )
        }
        
        static var marginBottom: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "margin",
                detail: "Внутренний отступ элементов от нижнего края",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "margin(, .bottom)",
                cursorOffset: 10
            )
        }
        
        static var marginLeading: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "margin",
                detail: "Внутренний отступ элементов от левого края",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "margin(, .leading)",
                cursorOffset: 11
            )
        }
        
        static var marginTrailing: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "margin",
                detail: "Внутренний отступ элементов от правого края",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "margin(, .trailing)",
                cursorOffset: 12
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
                label: "subfigure",
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
                insertText: "tint()",
                cursorOffset: 1
            )
        }
        
        static var background: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "background",
                detail: "Цвет фона",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "background()",
                cursorOffset: 1
            )
        }
        
        static var textAlignment: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "textAlignment",
                detail: "Выравнивание текста",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "textAlignment()",
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
                detail: "Подчеркивание (цвет по умолчанию - black)",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "underline()",
                cursorOffset: 1
            )
        }
        
        static var underlineDash: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "underline",
                detail: "Подчеркивание тире",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "underline(.dash, )",
                cursorOffset: 1
            )
        }
        
        static var underlineDashDot: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "underline",
                detail: "Подчеркивание тире - точка",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "underline(.dashDot, )",
                cursorOffset: 1
            )
        }
        
        static var underlineDashDotDot: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "underline",
                detail: "Подчеркивание тире - точка - точка",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "underline(.dashDotDot, )",
                cursorOffset: 1
            )
        }
        
        static var underlineSolid: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "underline",
                detail: "Подчеркивание сплошной линией",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "underline(.solid, )",
                cursorOffset: 1
            )
        }
        
        static var strikethrough: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "strikethrough",
                detail: "Зачеркивание (цвет по умолчанию - black)",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "strikethrough()",
                cursorOffset: 1
            )
        }
        
        static var strikethroughDash: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "strikethrough",
                detail: "Зачеркивание тире",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "strikethrough(.dash, )",
                cursorOffset: 1
            )
        }
        
        static var strikethroughDashDot: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "strikethrough",
                detail: "Зачеркивание тире - точка",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "strikethrough(.dashDot, )",
                cursorOffset: 1
            )
        }
        
        static var strikethroughDashDotDot: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "strikethrough",
                detail: "Зачеркивание тире - точка - точка",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "strikethrough(.dashDotDot, )",
                cursorOffset: 1
            )
        }
        
        static var strikethroughSolid: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "strikethrough",
                detail: "Зачеркивание сплошной линией",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "strikethrough(.solid, )",
                cursorOffset: 1
            )
        }
        
        static var fontSize: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "fontSize",
                detail: "Размер шрифта",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "fontSize()",
                cursorOffset: 1
            )
        }
        
        static var fontStyle: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "fontStyle",
                detail: "Стиль шрифта",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "fontStyle()",
                cursorOffset: 1
            )
        }
        
        static var codeLanguage: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "language",
                detail: "Язык программирования",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "language()",
                cursorOffset: 1
            )
        }
        
        static var codeStyle: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "style",
                detail: "Стиль подсветки",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "style()",
                cursorOffset: 1
            )
        }
        
        static var codeFrame: PageflowSuggestionEntry {
            PageflowSuggestionEntry(
                label: "frame",
                detail: "Рамка",
                image: Image(systemName: "m.square.fill"),
                imageColor: .blue,
                insertText: "frame()",
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
