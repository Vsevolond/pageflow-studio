//
//  FrameModifiers.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import Foundation

enum FrameModifiers: ASTNode {
    
    // MARK: - Cases
    
    case width(WidthModifier)
    case height(HeightModifier)
    
    // MARK: - Internal Properties
    
    var range: NSRange {
        switch self {
        case .width(let widthModifier):
            widthModifier.range
            
        case .height(let heightModifier):
            heightModifier.range
        }
    }
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        switch self {
        case .width(let widthModifier):
            try widthModifier.validate(with: storage)
            
        case .height(let heightModifier):
            try heightModifier.validate(with: storage)
        }
    }
}

// MARK: - Modifiers

struct WidthModifier: ASTNode {
    
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

struct HeightModifier: ASTNode {
    
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
