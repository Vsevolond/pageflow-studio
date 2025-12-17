//
//  AlignmentModifiers.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import Foundation

enum AlignmentModifiers: ASTNode {
    
    // MARK: - Cases
    
    case layout(LayoutModifier)
    
    // MARK: - Internal Properties
    
    var range: NSRange {
        switch self {
        case .layout(let layoutModifier):
            layoutModifier.range
        }
    }
}

// MARK: - Modifiers

struct LayoutModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: AlignmentType
    let range: NSRange
}
