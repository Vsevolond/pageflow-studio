//
//  VerticalAlignmentType.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import SwiftUI

struct VerticalAlignmentType: ASTNode {
    
    // MARK: - Type Entities
    
    enum Value: String {
        case center, top, bottom
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

extension VerticalAlignmentType {
    
    var rawValue: VerticalAlignment {
        switch value {
        case .center:
            return .center
            
        case .top:
            return .top
            
        case .bottom:
            return .bottom
        }
    }
}
