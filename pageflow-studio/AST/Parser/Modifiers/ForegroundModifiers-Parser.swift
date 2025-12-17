//
//  ForegroundModifiers-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
//
//    foreground_modifiers: $ => $.tint_modifier
//
    func foregroundModifiers(
        from node: Node
    ) throws(ASTParseError) -> ForegroundModifiers {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "tint_modifier":
            let modifier = try tintModifier(from: child)
            return .tint(modifier)
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//    
//    tint_modifier: $ => seq(
//        "tint",
//        "(",
//        $.color_type,
//        ")"
//    )
//    
    func tintModifier(
        from node: Node
    ) throws(ASTParseError) -> TintModifier {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "color_type":
            let value = try colorType(from: child)
            
            return TintModifier(
                value: value,
                range: node.range
            )
            
        default:
            throw .unknown(range: child.range)
        }
    }
}
