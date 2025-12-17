//
//  Constant.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 06.12.2025.
//

import Foundation

struct Constant: ASTNode {
    
    // MARK: - Type Entities
    
    enum Value: String {
        case width = "@width"
        case height = "@height"
    }
    
    // MARK: - Internal Properties
    
    let value: Value
    let range: NSRange
}
