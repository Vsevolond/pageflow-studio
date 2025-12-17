//
//  AddOperation.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import Foundation

struct AddOperation: ASTNode {
    
    // MARK: - Type Entities
    
    enum Value: String {
        case addition = "+"
        case substraction = "-"
    }
    
    // MARK: - Internal Properties
    
    let value: Value
    let range: NSRange
}
