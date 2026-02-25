//
//  TextEditingModifiers-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter
import Rearrange

extension ASTParserImpl {
    
//
//    text_editing_modifiers: $ => choice(
//        $.underline_modifier,
//        $.strikethrough_modifier
//    )
//
    func textEditingModifiers(
        from node: Node
    ) throws(ASTParseError) -> TextEditingModifiers {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "underline_modifier":
            let modifier = try underlineModifier(from: child)
            return .underline(modifier)
            
        case "strikethrough_modifier":
            let modifier = try strikethroughModifier(from: child)
            return .strikethrough(modifier)
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//    
//    underline_modifier: $ => seq(
//        token.immediate("underline"),
//        "(",
//        $.line_pattern_type,
//        optional(
//            seq(
//              ",",
//              $.color_type
//            )
//        ),
//        ")"
//    )
//
    func underlineModifier(
        from node: Node
    ) throws(ASTParseError) -> UnderlineModifier {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        guard child.nodeType == "line_pattern_type" else {
            throw .unknown(range: child.range)
        }
        
        let line = try linePatternType(from: child)
        
        if let child = child.nextNamedSibling {
            guard child.nodeType == "color_type" else {
                throw .unknown(range: child.range)
            }
            
            let color = try colorType(from: child)
            
            return UnderlineModifier(
                line: line,
                color: color,
                range: node.range
            )
            
        } else {
            let color = ColorType(value: .black, range: .notFound)
            
            return UnderlineModifier(
                line: line,
                color: color,
                range: node.range
            )
        }
    }
    
//    
//    strikethrough_modifier: $ => seq(
//        token.immediate("strikethrough"),
//        "(",
//        $.line_pattern_type,
//        optional(
//            seq(
//              ",",
//              $.color_type
//            )
//        ),
//        ")"
//    )
//
    func strikethroughModifier(
        from node: Node
    ) throws(ASTParseError) -> StrikethroughModifier {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        guard child.nodeType == "line_pattern_type" else {
            throw .unknown(range: child.range)
        }
        
        let line = try linePatternType(from: child)
        
        if let child = child.nextNamedSibling {
            guard child.nodeType == "color_type" else {
                throw .unknown(range: child.range)
            }
            
            let color = try colorType(from: child)
            
            return StrikethroughModifier(
                line: line,
                color: color,
                range: node.range
            )
            
        } else {
            let color = ColorType(value: .black, range: .notFound)
            
            return StrikethroughModifier(
                line: line,
                color: color,
                range: node.range
            )
        }
    }
}
