//
//  TextLayoutModifiers-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter

extension ASTParserImpl {
    
//
//    text_layout_modifiers: $ => choice(
//        $.text_alignment_modifier,
//        $.line_spacing_modifier
//    )
//
    func textLayoutModifiers(
        from node: Node
    ) throws(ASTParseError) -> TextLayoutModifiers {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "text_alignment_modifier":
            let modifier = try textAlignmentModifier(from: child)
            return .textAlignment(modifier)
            
        case "line_spacing_modifier":
            let modifier = try lineSpacingModifier(from: child)
            return .lineSpacing(modifier)
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//    
//    text_alignment_modifier: $ => seq(
//        token.immediate("textAlignment"),
//        "(",
//        $.horizontal_alignment_type,
//        ")"
//    )
//    
    func textAlignmentModifier(
        from node: Node
    ) throws(ASTParseError) -> TextAlignmentModifier {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "horizontal_alignment_type":
            let value = try horizontalAlignmentType(from: child)
            
            return TextAlignmentModifier(
                value: value,
                range: node.range
            )
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//    
//    line_spacing_modifier: $ => seq(
//        token.immediate("lineSpacing"),
//        "(",
//        $.expression,
//        ")"
//    )
//    
    func lineSpacingModifier(
        from node: Node
    ) throws(ASTParseError) -> LineSpacingModifier {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "expression":
            let value = try expression(from: child)
            
            return LineSpacingModifier(
                value: value,
                range: node.range
            )
            
        default:
            throw .unknown(range: child.range)
        }
    }
}
