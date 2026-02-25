//
//  CodeFrameType.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import Foundation

struct CodeFrameType: ASTNode {
    
    // MARK: - Type Entities
    
    enum Value: String {
        case lefline, topline, bottomline, lines, single
    }
    
    // MARK: - Internal Properties
    
    let value: Value
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        /// not required
    }
}
