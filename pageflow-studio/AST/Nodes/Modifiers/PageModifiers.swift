//
//  PageModifiers.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import Foundation

enum PageModifiers: ASTNode {
    
    // MARK: - Cases
    
    case header(HeaderModifier)
    case footer(FooterModifier)
    
    // MARK: - Internal Properties
    
    var range: NSRange {
        switch self {
        case .header(let headerModifier):
            headerModifier.range
            
        case .footer(let footerModifier):
            footerModifier.range
        }
    }
}

// MARK: - Modifiers

struct HeaderModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: [TextFragment]
    let range: NSRange
}

struct FooterModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: [TextFragment]
    let range: NSRange
}
