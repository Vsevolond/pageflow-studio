//
//  Number.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 06.12.2025.
//

import Foundation

struct Number: ASTNode {
    
    // MARK: - Type Entities
    
    enum Value: Equatable, Hashable {
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
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        /// not required
    }
}

// MARK: - Extensions

extension Number: Measurable {
    
    // MARK: - Internal Properties
    
    var isMeasured: Bool {
        unit != nil
    }
    
    var points: CGFloat {
        switch unit?.value {
        case .pt:
            return value.realValue
            
        case .cm:
            return value.realValue * 720 / 25.4
            
        case .mm:
            return value.realValue * 72 / 25.4
            
        case .in:
            return value.realValue * 72
            
        default:
            return value.realValue
        }
    }
}

// MARK: - Private Extensions

private extension Number.Value {
    
    // MARK: - Internal Properties
    
    var realValue: CGFloat {
        switch self {
        case .integer(let int): CGFloat(int)
        case .decimal(let double): CGFloat(double)
        }
    }
}
