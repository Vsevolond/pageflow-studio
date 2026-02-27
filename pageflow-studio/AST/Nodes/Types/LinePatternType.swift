//
//  LinePatternType.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import AppKit

struct LinePatternType: ASTNode {
    
    // MARK: - Type Entities
    
    enum Value: String {
        case dash, dashDot, dashDotDot, dot, solid
    }
    
    // MARK: - Internal Properties
    
    let value: Value
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        /// not required
    }
}

// MARK: - Extensions

extension LinePatternType {
    
    var rawValue: NSUnderlineStyle {
        switch value {
        case .dash:
            return .patternDash
            
        case .dashDot:
            return .patternDashDot
            
        case .dashDotDot:
            return .patternDashDotDot
            
        case .dot:
            return .patternDot
            
        case .solid:
            return .single
        }
    }
}
