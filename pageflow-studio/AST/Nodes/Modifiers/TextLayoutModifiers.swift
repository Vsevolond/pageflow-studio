//
//  TextLayoutModifiers.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import Foundation

enum TextLayoutModifiers: ASTNode {
    
    // MARK: - Cases
    
    case textAlignment(TextAlignmentModifier)
    case lineSpacing(LineSpacingModifier)
    
    // MARK: - Internal Properties
    
    var range: NSRange {
        switch self {
        case .textAlignment(let textAlignmentModifier):
            textAlignmentModifier.range
            
        case .lineSpacing(let lineSpacingModifier):
            lineSpacingModifier.range
        }
    }
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        switch self {
        case .textAlignment(let textAlignmentModifier):
            try textAlignmentModifier.validate(with: storage)
            
        case .lineSpacing(let lineSpacingModifier):
            try lineSpacingModifier.validate(with: storage)
        }
    }
}

// MARK: - Modifiers

struct TextAlignmentModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: HorizontalAlignmentType
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        try value.validate(with: storage)
    }
}

struct LineSpacingModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: Expression
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        try value.validate(with: storage)
        
        guard value.isMeasured else {
            throw .invalid(expression: value)
        }
    }
}
