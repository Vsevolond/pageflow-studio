//
//  AlignmentModifiers.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import SwiftUI

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
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        switch self {
        case .layout(let layoutModifier):
            try layoutModifier.validate(with: storage)
        }
    }
}

// MARK: - Modifiers

struct LayoutModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: AlignmentType
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        try value.validate(with: storage)
    }
}

// MARK: - Extensions

extension LayoutModifier {
    
    var rawValue: Alignment {
        value.rawValue
    }
}
