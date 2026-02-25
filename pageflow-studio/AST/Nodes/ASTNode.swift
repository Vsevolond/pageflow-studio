//
//  ASTNode.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 06.12.2025.
//

import Foundation
import Rearrange

// MARK: - AST Node

protocol ASTNode: Validatable, Equatable {
    
    // MARK: - Internal Properties
    
    var range: NSRange { get }
}

// MARK: - Extensions

extension Array: ASTNode where Element: ASTNode {
    
    // MARK: - Internal Properties
    
    var range: NSRange {
        let start = first.flatMap { $0.range.location } ?? .zero
        let end = last.flatMap { $0.range.location + $0.range.length } ?? .zero
        
        return NSRange(location: start, length: end - start)
    }
}

extension Array: Validatable where Element: Validatable {
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        for node in self {
            try node.validate(with: storage)
        }
    }
}
