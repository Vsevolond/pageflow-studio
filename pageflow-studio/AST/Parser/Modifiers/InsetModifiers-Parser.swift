//
//  InsetModifiers-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
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
//        "margin",
//        "(",
//        $.edge_type,
//        ",",
//        $.expression,
//        ")"
//    )
//    
    func marginModifier(
        from node: Node
    ) throws(ASTParseError) -> MarginModifier {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        guard child.nodeType == "edge_type" else {
            throw .unknown(range: child.range)
        }
        
        let edge = try edgeType(from: child)
        
        guard let child = child.nextNamedSibling else {
            throw .unknown(range: node.range)
        }
        
        guard child.nodeType == "expression" else {
            throw .unknown(range: node.range)
        }
        
        let value = try expression(from: child)
        
        return MarginModifier(
            edge: edge,
            value: value,
            range: node.range
        )
    }
}
