//
//  FigureModifiers-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter

extension ASTParserImpl {
    
//
//    figure_modifiers: $ => choice(
//        $.enumerated_modifier,
//        $.caption_modifier
//    )
//
    func figureModifiers(
        from node: Node
    ) throws(ASTParseError) -> FigureModifiers {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "enumerated_modifier":
            let modifier = try enumeratedModifier(from: child)
            return .enumerated(modifier)
            
        case "caption_modifier":
            let modifier = try captionModifier(from: child)
            return .caption(modifier)
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//    
//    enumerated_modifier: $ => seq(
//        token.immediate("enumerated"),
//        "(",
//        $.bool_type,
//        ")"
//    )
//    
    func enumeratedModifier(
        from node: Node
    ) throws(ASTParseError) -> EnumeratedModifier {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "bool_type":
            let value = try boolean(from: child)
            
            return EnumeratedModifier(
                value: value,
                range: node.range
            )
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//    
//    caption_modifier: $ => seq(
//        token.immediate("caption"),
//        "(",
//        $.text_content,
//        ")"
//    )
//    
    func captionModifier(
        from node: Node
    ) throws(ASTParseError) -> CaptionModifier {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "text_content":
            let value = try textContent(from: child)
            
            return CaptionModifier(
                value: value,
                range: node.range
            )
            
        default:
            throw .unknown(range: child.range)
        }
    }
}
