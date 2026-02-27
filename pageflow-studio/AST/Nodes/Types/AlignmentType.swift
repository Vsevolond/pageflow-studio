//
//  AlignmentType.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import SwiftUI

struct AlignmentType: ASTNode {
    
    // MARK: - Type Entities
    
    enum Value: String {
        case center, leading, trailing, top, bottom,
             topLeading, topTrailing, bottomLeading, bottomTrailing
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

extension AlignmentType {
    
    var rawValue: Alignment {
        switch value {
        case .center:
            return .center
            
        case .leading:
            return .leading
            
        case .trailing:
            return .trailing
            
        case .top:
            return .top
            
        case .bottom:
            return .bottom
            
        case .topLeading:
            return .topLeading
            
        case .topTrailing:
            return .topTrailing
            
        case .bottomLeading:
            return .bottomLeading
            
        case .bottomTrailing:
            return .bottomTrailing
        }
    }
}
