//
//  BackgroundModifiers-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
//
//    background_modifiers: $ => $.background_modifier
//
    func backgroundModifiers(
        from node: Node
    ) throws(ASTParseError) -> BackgroundModifiers {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "background_modifier":
            let modifier = try backgroundModifier(from: child)
            return .background(modifier)
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//    
//    background_modifier: $ => seq(
//        "background",
//        "(",
//        $.color_type,
//        ")"
//    )
//    
    func backgroundModifier(
        from node: Node
    ) throws(ASTParseError) -> BackgroundModifier {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "color_type":
            let value = try colorType(from: child)
            
            return BackgroundModifier(
                value: value,
                range: node.range
            )
            
        default:
            throw .unknown(range: child.range)
        }
    }
}
