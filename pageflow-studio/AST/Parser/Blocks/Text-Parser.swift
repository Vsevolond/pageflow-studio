//
//  Text-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 14.12.2025.
//

import Foundation
import SwiftTreeSitter

extension ASTParser {
    
//
//    text_block: $ => seq(
//        "Text",
//        "{",
//        repeat($.text_fragment),
//        "}",
//        repeat($.text_modifier)
//    )
//
    func textBlock(
        from node: Node
    ) throws(ASTParseError) -> TextBlock {
        var fragments: [TextFragment] = []
        var modifiers: [TextBlock.Modifier] = []
        
        for index in 0..<node.namedChildCount {
            guard let child = node.namedChild(at: index) else {
                throw .unknown(range: node.range)
            }
            
            switch child.nodeType {
            case "text_fragment":
                let fragment = try textFragment(from: child)
                fragments.append(fragment)
                
            case "text_modifier":
                let modifier = try textModifier(from: child)
                modifiers.append(modifier)
                
            default:
                throw .unknown(range: child.range)
            }
        }
        
        return TextBlock(
            fragments: fragments,
            modifiers: modifiers,
            range: node.range
        )
    }
    
//
//    text_modifier: $ => seq(
//        ".",
//        choice(
//            $.text_layout_modifiers,
//            $.text_editing_modifiers,
//            $.font_modifiers,
//            $.frame_modifiers,
//            $.layout_modifiers,
//            $.alignment_modifiers,
//            $.foreground_modifiers,
//            $.background_modifiers
//        )
//    )
//
    func textModifier(
        from node: Node
    ) throws(ASTParseError) -> TextBlock.Modifier {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "text_layout_modifiers":
            let modifier = try textLayoutModifiers(from: child)
            return .textLayout(modifier)
            
        case "text_editing_modifiers":
            let modifier = try textEditingModifiers(from: child)
            return .textEditing(modifier)
            
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
