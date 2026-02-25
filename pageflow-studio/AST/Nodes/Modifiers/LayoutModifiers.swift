//
//  LayoutModifiers.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import Foundation

enum LayoutModifiers: ASTNode {
    
    // MARK: - Cases
    
    case padding(PaddingModifier)
    case offset(OffsetModifier)
    
    // MARK: - Internal Properties
    
    var range: NSRange {
        switch self {
        case .padding(let paddingModifier):
            paddingModifier.range
            
        case .offset(let offsetModifier):
            offsetModifier.range
        }
    }
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        switch self {
        case .padding(let paddingModifier):
            try paddingModifier.validate(with: storage)
            
        case .offset(let offsetModifier):
            try offsetModifier.validate(with: storage)
        }
    }
}

// MARK: - Modifiers

struct PaddingModifier: ASTNode {
    
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

struct OffsetModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: Expression
    let axis: AxisType
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        try value.validate(with: storage)
        try axis.validate(with: storage)
        
        guard value.isMeasured else {
            throw .invalid(expression: value)
        }
    }
}
