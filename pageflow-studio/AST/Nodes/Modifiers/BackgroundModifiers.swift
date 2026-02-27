//
//  BackgroundModifiers.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import SwiftUI

enum BackgroundModifiers: ASTNode {
    
    // MARK: - Cases
    
    case background(BackgroundModifier)
    
    // MARK: - Internal Properties
    
    var range: NSRange {
        switch self {
        case .background(let backgroundModifier):
            backgroundModifier.range
        }
    }
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        switch self {
        case .background(let backgroundModifier):
            try backgroundModifier.validate(with: storage)
        }
    }
}

// MARK: - Modifiers

struct BackgroundModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: ColorType
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        try value.validate(with: storage)
    }
}

// MARK: - Extensions

extension BackgroundModifier {
    
    var rawValue: NSColor {
        value.rawValue
    }
}
