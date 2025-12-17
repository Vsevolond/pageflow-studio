//
//  Expression-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter

extension ASTParser {

//
//    expression: $ => prec.left(
//        1,
//        choice(
//            $.term,
//            seq($.expression, $.add_operation, $.term)
//        )
//    )
//
    func expression(
        from node: Node
    ) throws(ASTParseError) -> Expression {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "term":
            let term = try term(from: child)
            return .term(term)
            
        case "expression":
            let expression = try expression(from: child)
            
            guard let child = child.nextNamedSibling else {
                throw .unknown(range: node.range)
            }
            
            guard child.nodeType == "add_operation" else {
                throw .unknown(range: child.range)
            }
            
            let addOperation = try addOperation(from: child)
            
            guard let child = child.nextNamedSibling else {
                throw .unknown(range: node.range)
            }
            
            guard child.nodeType == "term" else {
                throw .unknown(range: child.range)
            }
            
            let term = try term(from: child)
            
            return .binary(expression, addOperation, term)
            
        default:
            throw .unknown(range: child.range)
        }
    }
}
