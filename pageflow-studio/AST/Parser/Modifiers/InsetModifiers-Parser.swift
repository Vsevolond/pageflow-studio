//
//  InsetModifiers-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter
import Rearrange

extension ASTParserImpl {
    
//
//    inset_modifiers: $ => $.margin_modifier
//
    func insetModifiers(
        from node: Node
    ) throws(ASTParseError) -> InsetModifiers {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "margin_modifier":
            let modifier = try marginModifier(from: child)
            return .margin(modifier)
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//    
//    margin_modifier: $ => seq(
//        token.immediate("margin"),
//        "(",
//        $.expression,
//        optional(
//            seq(
//              ",",
//              $.edge_type
//            )
//        ),
//        ")"
//    )
//
    func marginModifier(
        from node: Node
    ) throws(ASTParseError) -> MarginModifier {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        guard child.nodeType == "expression" else {
            throw .unknown(range: child.range)
        }
        
        let value = try expression(from: child)
        
        if let child = child.nextNamedSibling {
            guard child.nodeType == "edge_type" else {
                throw .unknown(range: child.range)
            }
            
            let edge = try edgeType(from: child)
            
            return MarginModifier(
                value: value,
                edge: edge,
                range: node.range
            )
            
        } else {
            let edge = EdgeType(value: .all, range: .notFound)
            
            return MarginModifier(
                value: value,
                edge: edge,
                range: node.range
            )
        }
    }
}
