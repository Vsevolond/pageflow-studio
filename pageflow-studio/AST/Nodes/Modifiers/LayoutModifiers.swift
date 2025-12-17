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
}

// MARK: - Modifiers

struct PaddingModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let edge: EdgeType
    let value: Expression
    let range: NSRange
}

struct OffsetModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let axis: AxisType
    let value: Expression
    let range: NSRange
}
