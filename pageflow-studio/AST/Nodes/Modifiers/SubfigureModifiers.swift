//
//  SubfigureModifiers.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import Foundation

enum SubfigureModifiers: ASTNode {
    
    // MARK: - Cases
    
    case subfigure(SubfigureModifier)
    
    // MARK: - Internal Properties
    
    var range: NSRange {
        switch self {
        case .subfigure(let subfigureModifier):
            subfigureModifier.range
        }
    }
}

// MARK: - Modifiers

struct SubfigureModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: Bool
    let range: NSRange
}
