//
//  Math-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 14.12.2025.
//

import SwiftTreeSitter

extension ASTParserImpl {
    
//
//    math_block: $ => seq(
//        "Math",
//        "{",
//        $.math_content,
//        "}",
//        repeat($.math_modifier)
//    )
//
    func mathBlock(
        from node: Node
    ) throws(ASTParseError) -> MathBlock {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        guard child.nodeType == "math_content" else {
            throw .unknown(range: child.range)
        }
        
        let content = try mathContent(from: child)
        
        var modifiers: [MathBlock.Modifier] = []
        
        for index in 0..<node.namedChildCount {
            guard let child = node.namedChild(at: index) else {
                throw .unknown(range: node.range)
            }
            
            switch child.nodeType {
            case "math_modifier":
                let modifier = try mathModifier(from: child)
                modifiers.append(modifier)
                
            default:
                throw .unknown(range: child.range)
            }
        }
        
        return MathBlock(
            content: content,
            modifiers: modifiers,
            range: node.range
        )
    }
    
//
//    math_modifier: $ => seq(
//        ".",
//        choice(
//            $.text_layout_modifiers,
//            $.font_modifiers,
//            $.frame_modifiers,
//            $.layout_modifiers,
//            $.alignment_modifiers,
//            $.inset_modifiers,
//            $.foreground_modifiers,
//            $.background_modifiers
//        )
//    )
//
    func mathModifier(
        from node: Node
    ) throws(ASTParseError) -> MathBlock.Modifier {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "text_layout_modifiers":
            let modifier = try textLayoutModifiers(from: child)
            return .textLayout(modifier)
            
        case "font_modifiers":
            let modifier = try fontModifiers(from: child)
            return .font(modifier)
            
        case "frame_modifiers":
            let modifier = try frameModifiers(from: child)
            return .frame(modifier)
            
        case "layout_modifiers":
            let modifier = try layoutModifiers(from: child)
            return .layout(modifier)
            
        case "alignment_modifiers":
            let modifier = try alignmentModifiers(from: child)
            return .alignment(modifier)
            
        case "inset_modifiers":
            let modifier = try insetModifiers(from: child)
            return .inset(modifier)
            
        case "foreground_modifiers":
            let modifier = try foregroundModifiers(from: child)
            return .foreground(modifier)
            
        case "background_modifiers":
            let modifier = try backgroundModifiers(from: child)
            return .background(modifier)
            
        default:
            throw .unknown(range: child.range)
        }
    }
}
