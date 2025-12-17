//
//  Term-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
//
//    term: $ => prec.left(
//        2,
//        choice(
//            $.factor,
//            seq($.term, $.mul_operation, $.factor)
//        )
//    )
//
    func term(
        from node: Node
    ) throws(ASTParseError) -> Term {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "factor":
            let factor = try factor(from: child)
            return .factor(factor)
            
        case "term":
            let term = try term(from: child)
            
            guard let child = child.nextNamedSibling else {
                throw .unknown(range: node.range)
            }
            
            guard child.nodeType == "mul_operation" else {
                throw .unknown(range: child.range)
            }
            
            let mulOperation = try mulOperation(from: child)
            
            guard let child = child.nextNamedSibling else {
                throw .unknown(range: node.range)
            }
            
            guard child.nodeType == "factor" else {
                throw .unknown(range: child.range)
            }
            
            let factor = try factor(from: child)
            
            return .multiply(term, mulOperation, factor)
            
        default:
            throw .unknown(range: child.range)
        }
    }
}
