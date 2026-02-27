//
//  EdgeType.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import SwiftUI

struct EdgeType: ASTNode {
    
    // MARK: - Type Entities
    
    enum Value: String {
        case top, bottom, leading, trailing, all
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

extension EdgeType {
    
    var rawValue: Edge.Set {
        switch value {
        case .top:
            return .top
            
        case .bottom:
            return .bottom
            
        case .leading:
            return .leading
            
        case .trailing:
            return .trailing
            
        case .all:
            return .all
        }
    }
}
