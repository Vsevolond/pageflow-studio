//
//  AxisType.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import Foundation

struct AxisType: ASTNode {
    
    // MARK: - Type Entities
    
    enum Value: String {
        case vertical, horizontal
    }
    
    // MARK: - Internal Properties
    
    let value: Value
    let range: NSRange
}
