//
//  Number.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 06.12.2025.
//

import Foundation

struct Number: ASTNode {
    
    // MARK: - Type Entities
    
    enum Value {
        case integer(Int)
        case decimal(Double)
    }
    
    // MARK: - Internal Properties
    
    let value: Value
    let unit: MeasureUnit?
    let range: NSRange
    
    // MARK: - Initializers
    
    init(
        value: Value,
        unit: MeasureUnit? = nil,
        range: NSRange
    ) {
        self.value = value
        self.unit = unit
        self.range = range
    }
}
