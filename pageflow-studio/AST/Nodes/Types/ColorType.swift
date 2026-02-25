//
//  ColorType.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import Foundation

struct ColorType: ASTNode {
    
    // MARK: - Type Entities
    
    enum Value: String {
        case red, green, blue, cyan, magenta, yellow,
             black, gray, white, darkGray, lightGray, brown,
             lime, olive, orange, pink, purple, teal, violet
    }
    
    // MARK: - Internal Properties
    
    let value: Value
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        /// not required
    }
}
