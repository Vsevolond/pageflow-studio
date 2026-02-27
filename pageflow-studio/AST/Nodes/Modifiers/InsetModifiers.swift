//
//  InsetModifiers.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import SwiftUI

enum InsetModifiers: ASTNode {
    
    // MARK: - Cases
    
    case margin(MarginModifier)
    
    // MARK: - Internal Properties
    
    var range: NSRange {
        switch self {
        case .margin(let marginModifier):
            marginModifier.range
        }
    }
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        switch self {
        case .margin(let marginModifier):
            try marginModifier.validate(with: storage)
        }
    }
}

// MARK: - Modifiers

struct MarginModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: Expression
    let edge: EdgeType
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        try value.validate(with: storage)
        try edge.validate(with: storage)
        
        guard value.isMeasured else {
            throw .invalid(expression: value)
        }
    }
}

// MARK: - Extensions

extension MarginModifier {
    
    var rawValue: CGFloat {
        value.points
    }
    
    var rawEdge: Edge.Set {
        edge.rawValue
    }
}
