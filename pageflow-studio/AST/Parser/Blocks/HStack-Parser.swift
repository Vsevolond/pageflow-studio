//
//  HStack-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 14.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
//
//    hstack_block: $ => seq(
//        "HStack",
//        "{",
//        repeat($.hstack_content),
//        "}",
//        repeat($.hstack_modifier)
//    )
//
    func hStackBlock(
        from node: Node
    ) throws(ASTParseError) -> HStackBlock {
        var stackContent: [BaseContent] = []
        var modifiers: [HStackBlock.Modifier] = []
        
        for index in 0..<node.namedChildCount {
            guard let child = node.namedChild(at: index) else {
                throw .unknown(range: node.range)
            }
            
            switch child.nodeType {
            case "content":
                let hStackContent = try content(from: child)
                stackContent.append(hStackContent)
                
            case "hstack_modifier":
                let hStackModifier = try hStackModifier(from: child)
                modifiers.append(hStackModifier)
                
            default:
                throw .unknown(range: child.range)
            }
        }
        
        return HStackBlock(
            content: stackContent,
            modifiers: modifiers,
            range: node.range
        )
    }
    
//
//    hstack_modifier: $ => seq(
//        ".",
//        choice(
//            $.frame_modifiers,
//            $.layout_modifiers,
//            $.inset_modifiers,
//            $.container_modifiers,
//            $.figure_modifiers,
//            $.subfigure_modifiers,
//            $.alignment_modifiers,
//            $.background_modifiers,
//            $.halignment_modifier
//        )
//    )
//
    func hStackModifier(
        from node: Node
    ) throws(ASTParseError) -> HStackBlock.Modifier {
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
            
        case "inset_modifiers":
            let modifier = try insetModifiers(from: child)
            return .inset(modifier)
            
        case "container_modifiers":
            let modifier = try containerModifiers(from: child)
            return .container(modifier)
            
        case "figure_modifiers":
            let modifier = try figureModifiers(from: child)
            return .figure(modifier)
            
        case "subfigure_modifiers":
            let modifier = try subfigureModifiers(from: child)
            return .subfigure(modifier)
            
        case "alignment_modifiers":
            let modifier = try alignmentModifiers(from: child)
            return .alignment(modifier)
            
        case "background_modifiers":
            let modifier = try backgroundModifiers(from: child)
            return .background(modifier)
            
        case "halignment_modifier":
            let modifier = try hAlignmentModifier(from: child)
            return .stackAlignment(modifier)
            
        default:
            throw .unknown(range: child.range)
        }
    }
}
