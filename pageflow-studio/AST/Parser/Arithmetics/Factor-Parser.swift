//
//  Factor-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
//
//    factor: $ => choice(
//        $.unary_factor,
//        $.primary_factor
//    )
//
    func factor(
        from node: Node
    ) throws(ASTParseError) -> Factor {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "unary_factor":
            let unaryFactor = try unaryFactor(from: child)
            return .unary(unaryFactor)
            
        case "primary_factor":
            let primaryFactor = try primaryFactor(from: child)
            return .primary(primaryFactor)
            
        default:
            throw .unknown(range: child.range)
        }
    }
}
