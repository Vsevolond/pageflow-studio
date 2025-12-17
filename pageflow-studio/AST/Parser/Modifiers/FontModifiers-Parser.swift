//
//  FontModifiers-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
//
//    font_modifiers: $ => choice(
//        $.font_size_modifier,
//        $.font_style_modifier
//    )
//
    func fontModifiers(
        from node: Node
    ) throws(ASTParseError) -> FontModifiers {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "font_size_modifier":
            let modifier = try fontSizeModifier(from: child)
            return .fontSize(modifier)
            
        case "font_style_modifier":
            let modifier = try fontStyleModifier(from: child)
            return .fontStyle(modifier)
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//    
//    font_size_modifier: $ => seq(
//        "fontSize",
//        "(",
//        $.font_size_type,
//        ")"
//    )
//    
    func fontSizeModifier(
        from node: Node
    ) throws(ASTParseError) -> FontSizeModifier {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "font_size_type":
            let value = try fontSizeType(from: child)
            
            return FontSizeModifier(
                value: value,
                range: node.range
            )
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//    
//    font_style_modifier: $ => seq(
//        "fontStyle",
//        "(",
//        $.font_style_type,
//        ")"
//    )
//    
    func fontStyleModifier(
        from node: Node
    ) throws(ASTParseError) -> FontStyleModifier {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "font_style_type":
            let value = try fontStyleType(from: child)
            
            return FontStyleModifier(
                value: value,
                range: node.range
            )
            
        default:
            throw .unknown(range: child.range)
        }
    }
}
