//
//  TextFragment.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 06.12.2025.
//

import Foundation

struct TextFragment: ASTNode {
    
    // MARK: - Type Entities
    
    enum Value: Equatable {
        case rawText(String)
        case rawMath(MathContent)
        case newline
    }
    
    // MARK: - Internal Properties
    
    let value: Value
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        guard case .rawMath(let mathContent) = value else {
            return
        }
        
        try mathContent.validate(with: storage)
    }
}
