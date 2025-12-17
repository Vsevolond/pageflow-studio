//
//  SubfigureModifiers-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
//
//    subfigure_modifiers: $ => $.subfigure_modifier
//
    func subfigureModifiers(
        from node: Node
    ) throws(ASTParseError) -> SubfigureModifiers {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "subfigure_modifier":
            let modifier = try subfigureModifier(from: child)
            return .subfigure(modifier)
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//    
//    subfigure_modifier: $ => seq(
//        "subfigure",
//        "(",
//        $.bool_type,
//        ")"
//    )
//    
    func subfigureModifier(
        from node: Node
    ) throws(ASTParseError) -> SubfigureModifier {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "bool_type":
            let value = try boolean(from: child)
            
            return SubfigureModifier(
                value: value,
                range: node.range
            )
            
        default:
            throw .unknown(range: child.range)
        }
    }
}
