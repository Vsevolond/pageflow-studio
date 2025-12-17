//
//  FigureModifiers.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import Foundation

enum FigureModifiers: ASTNode {
    
    // MARK: - Cases
    
    case enumerated(EnumeratedModifier)
    case caption(CaptionModifier)
    
    // MARK: - Internal Modifier
    
    var range: NSRange {
        switch self {
        case .enumerated(let enumeratedModifier):
            enumeratedModifier.range
            
        case .caption(let captionModifier):
            captionModifier.range
        }
    }
}

// MARK: - Modifiers

struct EnumeratedModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: Bool
    let range: NSRange
}

struct CaptionModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: [TextFragment]
    let range: NSRange
}
