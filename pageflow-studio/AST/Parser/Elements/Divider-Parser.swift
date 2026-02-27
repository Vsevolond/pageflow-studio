//
//  Divider-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter
import CodeEditTextView

extension ASTParserImpl {
    
//
//    divider_element: $ => seq(
//        "Divider",
//        "(",
//        $.expression,
//        ")",
//        repeat($.divider_modifier)
//    )
//
    func dividerElement(
        from node: Node
    ) throws(ASTParseError) -> DividerElement {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        guard child.nodeType == "expression" else {
            throw .unknown(range: child.range)
        }
        
        if child.range.isEmpty {
            let modifiers = try modifiers(from: node)
            
            return DividerElement(
                modifiers: modifiers,
                range: node.range
            )
            
        } else {
            let thickness = try expression(from: child)
            let modifiers = try modifiers(from: node)
            
            return DividerElement(
                thickness: thickness,
                modifiers: modifiers,
                range: node.range
            )
            
        }
        
        func modifiers(
            from node: Node
        ) throws(ASTParseError) -> [DividerElement.Modifier] {
            var modifiers: [DividerElement.Modifier] = []
            
            for index in 1..<node.namedChildCount {
                guard let child = node.namedChild(at: index) else {
                    throw .unknown(range: node.range)
                }
                
                guard child.nodeType == "divider_modifier" else {
                    throw .unknown(range: child.range)
                }
                
                let modifier = try dividerModifier(from: child)
                modifiers.append(modifier)
            }
            
            return modifiers
        }
    }
    
//
//    divider_modifier: $ => seq(
//        ".",
//        choice(
//            $.frame_modifiers,
//            $.layout_modifiers,
//            $.alignment_modifiers,
//            $.foreground_modifiers
//        )
//    )
//
    func dividerModifier(
        from node: Node
    ) throws(ASTParseError) -> DividerElement.Modifier {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
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
            
        default:
            throw .unknown(range: child.range)
        }
    }
}
