//
//  MulOperation.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import Foundation

struct MulOperation: ASTNode {
    
    // MARK: - Type Entities
    
    enum Value: String {
        case multiplication = "*"
        case division = "/"
    }
    
    // MARK: - Internal Properties
    
    let value: Value
    let range: NSRange
}
