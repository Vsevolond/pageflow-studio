//
//  FontModifiers.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import Foundation

enum FontModifiers: ASTNode {
    
    // MARK: - Cases
    
    case fontSize(FontSizeModifier)
    case fontStyle(FontStyleModifier)
    
    // MARK: - Internal Properties
    
    var range: NSRange {
        switch self {
        case .fontSize(let fontSizeModifier):
            fontSizeModifier.range
            
        case .fontStyle(let fontStyleModifier):
            fontStyleModifier.range
        }
    }
    
    // MARK: - Internal Properties
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        switch self {
        case .fontSize(let fontSizeModifier):
            try fontSizeModifier.validate(with: storage)
            
        case .fontStyle(let fontStyleModifier):
            try fontStyleModifier.validate(with: storage)
        }
    }
}

// MARK: - Modifiers

struct FontSizeModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: FontSizeType
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        try value.validate(with: storage)
    }
}

struct FontStyleModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: FontStyleType
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        try value.validate(with: storage)
    }
}

// MARK: - Extensions

extension FontSizeModifier {
    
    var rawValue: CGFloat {
        value.rawValue
    }
}

extension FontStyleModifier {
    
    var rawValue: FontStyleType.Value {
        value.value
    }
}
