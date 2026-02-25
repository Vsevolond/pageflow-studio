//
//  VStack-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 14.12.2025.
//

import SwiftTreeSitter

extension ASTParserImpl {
    
//
//    vstack_block: $ => seq(
//        "VStack",
//        "{",
//        repeat($.content),
//        "}",
//        repeat($.vstack_modifier)
//    )
//
    func vStackBlock(
        from node: Node
    ) throws(ASTParseError) -> VStackBlock {
        var stackContent: [BaseContent] = []
        var modifiers: [VStackBlock.Modifier] = []
        
        for index in 0..<node.namedChildCount {
            guard let child = node.namedChild(at: index) else {
                throw .unknown(range: node.range)
            }
            
            switch child.nodeType {
            case "content":
                let vStackContent = try content(from: child)
                stackContent.append(vStackContent)
                
            case "vstack_modifier":
                let vStackModifier = try vStackModifier(from: child)
                modifiers.append(vStackModifier)
                
            default:
                throw .unknown(range: child.range)
            }
        }
        
        return VStackBlock(
            content: stackContent,
            modifiers: modifiers,
            range: node.range
        )
    }
    
//
//    vstack_modifier: $ => seq(
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
//            $.valignment_modifier
//        )
//    )
//
    func vStackModifier(
        from node: Node
    ) throws(ASTParseError) -> VStackBlock.Modifier {
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
            
        case "valignment_modifier":
            let modifier = try vAlignmentModifier(from: child)
            return .stackAlignment(modifier)
            
        default:
            throw .unknown(range: child.range)
        }
    }
}
