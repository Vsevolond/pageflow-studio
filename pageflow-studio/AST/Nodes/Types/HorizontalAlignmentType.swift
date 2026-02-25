//
//  HorizontalAlignmentType.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import Foundation

struct HorizontalAlignmentType: ASTNode {
    
    // MARK: - Type Entities
    
    enum Value: String {
        case center, leading, trailing
    }
    
    // MARK: - Internal Properties
    
    let value: Value
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        /// not required
    }
}
