//
//  ContainerModifiers-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter

extension ASTParserImpl {
    
//
//    container_modifiers: $ => $.spacing_modifier
//
    func containerModifiers(
        from node: Node
    ) throws(ASTParseError) -> ContainerModifiers {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "spacing_modifier":
            let modifier = try spacingModifier(from: child)
            return .spacing(modifier)
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//    
//    spacing_modifier: $ => seq(
//        token.immediate("spacing"),
//        "(",
//        $.expression,
//        ")"
//    )
//    
    func spacingModifier(
        from node: Node
    ) throws(ASTParseError) -> SpacingModifier {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "expression":
            let value = try expression(from: child)
            
            return SpacingModifier(
                value: value,
                range: node.range
            )
            
        default:
            throw .unknown(range: child.range)
        }
    }
}
