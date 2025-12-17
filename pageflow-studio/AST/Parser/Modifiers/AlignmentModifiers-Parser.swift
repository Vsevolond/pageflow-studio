//
//  AlignmentModifiers-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
//
//    alignment_modifiers: $ => $.layout_modifier
//
    func alignmentModifiers(
        from node: Node
    ) throws(ASTParseError) -> AlignmentModifiers {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "layout_modifier":
            let modifier = try layoutModifier(from: child)
            return .layout(modifier)
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//    
//    layout_modifier: $ => seq(
//        "layout",
//        "(",
//        $.alignment_type,
//        ")"
//    )
//    
    func layoutModifier(
        from node: Node
    ) throws(ASTParseError) -> LayoutModifier {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "alignment_type":
            let value = try alignmentType(from: child)
            
            return LayoutModifier(
                value: value,
                range: node.range
            )
            
        default:
            throw .unknown(range: child.range)
        }
    }
}
