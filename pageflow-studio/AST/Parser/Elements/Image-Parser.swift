//
//  Image-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 14.12.2025.
//

import SwiftTreeSitter

extension ASTParserImpl {
    
//
//    image_element: $ => seq(
//        "Image",
//        "(",
//        $.file_name,
//        ")",
//        repeat($.image_modifier)
//    )
//
    func imageElement(
        from node: Node
    ) throws(ASTParseError) -> ImageElement {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        guard child.nodeType == "file_name" else {
            throw .unknown(range: child.range)
        }
        
        let name = try fileName(from: child, type: .image)
        
        var modifiers: [ImageElement.Modifier] = []
        
        for index in 1..<node.namedChildCount {
            guard let child = node.namedChild(at: index) else {
                throw .unknown(range: node.range)
            }
            
            guard child.nodeType == "image_modifier" else {
                throw .unknown(range: child.range)
            }
            
            let modifier = try imageModifier(from: child)
            modifiers.append(modifier)
        }
        
        return ImageElement(
            name: name,
            modifiers: modifiers,
            range: node.range
        )
    }
    
//
//    image_modifier: $ => seq(
//        ".",
//        choice(
//            $.frame_modifiers,
//            $.layout_modifiers,
//            $.alignment_modifiers,
//            $.figure_modifiers,
//            $.subfigure_modifiers
//        )
//    )
//
    func imageModifier(
        from node: Node
    ) throws(ASTParseError) -> ImageElement.Modifier {
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
            
        case "figure_modifiers":
            let modifier = try figureModifiers(from: child)
            return .figure(modifier)
            
        case "subfigure_modifiers":
            let modifier = try subfigureModifiers(from: child)
            return .subfigure(modifier)
            
        default:
            throw .unknown(range: child.range)
        }
    }
}
