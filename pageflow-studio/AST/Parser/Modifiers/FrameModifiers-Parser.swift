//
//  FrameModifiers-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
//
//    frame_modifiers: $ => choice(
//        $.width_modifier,
//        $.height_modifier
//    )
//
    func frameModifiers(
        from node: Node
    ) throws(ASTParseError) -> FrameModifiers {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "width_modifier":
            let modifier = try widthModifier(from: child)
            return .width(modifier)
            
        case "height_modifier":
            let modifier = try heightModifier(from: child)
            return .height(modifier)
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//    
//    width_modifier: $ => seq(
//        "width",
//        "(",
//        $.expression,
//        ")"
//    )
//    
    func widthModifier(
        from node: Node
    ) throws(ASTParseError) -> WidthModifier {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "expression":
            let value = try expression(from: child)
            
            return WidthModifier(
                value: value,
                range: node.range
            )
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//    
//    height_modifier: $ => seq(
//        "height",
//        "(",
//        $.expression,
//        ")"
//    )
//    
    func heightModifier(
        from node: Node
    ) throws(ASTParseError) -> HeightModifier {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "expression":
            let value = try expression(from: child)
            
            return HeightModifier(
                value: value,
                range: node.range
            )
            
        default:
            throw .unknown(range: child.range)
        }
    }
}
