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
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        switch self {
        case .subfigure(let subfigureModifier):
            try subfigureModifier.validate(with: storage)
        }
    }
}

// MARK: - Modifiers

struct SubfigureModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: Bool
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        /// not required
    }
}
