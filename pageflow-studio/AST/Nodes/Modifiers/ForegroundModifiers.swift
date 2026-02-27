//
//  ForegroundModifiers.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import AppKit

enum ForegroundModifiers: ASTNode {
    
    // MARK: - Cases
    
    case tint(TintModifier)
    
    // MARK: - Internal Properties
    
    var range: NSRange {
        switch self {
        case .tint(let tintModifier):
            tintModifier.range
        }
    }
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        switch self {
        case .tint(let tintModifier):
            try tintModifier.validate(with: storage)
        }
    }
}

// MARK: - Modifiers

struct TintModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: ColorType
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        try value.validate(with: storage)
    }
}

// MARK: - Extensions

extension TintModifier {
    
    var rawValue: NSColor {
        value.rawValue
    }
}
