//
//  PrimaryFactor-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
//
//    primary_factor: $ => choice(
//        seq(
//            "(",
//            $.expression,
//            ")"
//        ),
//        $.constant,
//        $.number
//    )
//
    func primaryFactor(
        from node: Node
    ) throws(ASTParseError) -> PrimaryFactor {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "expression":
            let expression = try expression(from: child)
            return .expression(expression)
            
        case "constant":
            let constant = try constant(from: child)
            return .constant(constant)
            
        case "number":
            let number = try number(from: child)
            return .number(number)
            
        default:
            throw .unknown(range: child.range)
        }
    }
}
