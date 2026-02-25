//
//  PageflowSuggestionContext.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 21.02.2026.
//

import Foundation

enum PageflowSuggestionContext: Equatable {
    
    // MARK: - Blocks with content available
    
    enum Blocks: Equatable {
        case root
        case newPage, sectionNewPage
        case section, subSection
        case vStack, hStack, zStack
    }
    
    // MARK: - Elements with modifiers available
    
    enum Elements: Equatable {
        case newPage
        case vStack, hStack, zStack
        case text, math
        case divider
        case image, listing
    }
    
//    // MARK: - Modifiers with types available
//    
//    enum Modifiers: Equatable {
//        case vAlignment, hAlignment, zAlignment
//        case layout, offset, margin
//        case tint, background
//        case textAlignment
//        case underline, strikethrough
//        case fontSize, fontStyle
//        case codeLanguage, codeStyle, codeFrame
//    }
    
    // MARK: - Types with values available
    
    enum Types: Equatable {
        case horizontalAlignment, verticalAlignment, alignment
        case edge, axis
        case color
        case linePattern
        case fontSize, fontStyle
        case codeLanguage, codeStyle, codeFrame
    }
    
    // MARK: - Cases
    
    case content(Blocks)
    case modifier(Elements)
    case value(Types)
    case text
    case math
    case file
    case boolean
    case constant
}

