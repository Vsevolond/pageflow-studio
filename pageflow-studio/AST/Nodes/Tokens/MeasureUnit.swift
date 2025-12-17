//
//  MeasureUnit.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 06.12.2025.
//

import Foundation

struct MeasureUnit: ASTNode {
    
    // MARK: - Type Entities
    
    enum Value: String {
        case pt, cm, mm, `in`
    }
    
    // MARK: - Internal Properties
    
    let value: Value
    let range: NSRange
}
