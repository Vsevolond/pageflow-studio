//
//  UnaryFactor-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter

extension ASTParserImpl {
    
//
//    unary_factor: $ => seq(
//        $.add_operation,
//        $.primary_factor
//    )
//
    func unaryFactor(
        from node: Node
    ) throws(ASTParseError) -> UnaryFactor {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        guard child.nodeType == "add_operation" else {
            throw .unknown(range: child.range)
        }
        
        let operation = try addOperation(from: child)
        
        guard let child = child.nextNamedSibling else {
            throw .unknown(range: node.range)
        }
        
        guard child.nodeType == "primary_factor" else {
            throw .unknown(range: child.range)
        }
        
        let value = try primaryFactor(from: child)
        
        return UnaryFactor(
            operation: operation,
            value: value,
            range: node.range
        )
    }
}
