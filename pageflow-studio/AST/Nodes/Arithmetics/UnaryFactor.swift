//
//  UnaryFactor.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import Foundation

struct UnaryFactor: ASTNode {
    
    // MARK: - Internal Properties
    
    let operation: AddOperation
    let value: PrimaryFactor
    let range: NSRange
}
