//
//  FigureModifiers-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
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
//        "enumerated",
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
//        "caption",
//        "(",
//        repeat($.text_arg_fragment),
//        ")"
//    )
//    
    func captionModifier(
        from node: Node
    ) throws(ASTParseError) -> CaptionModifier {
        var value: [TextFragment] = []
        
        for index in 0..<node.namedChildCount {
            guard let child = node.namedChild(at: index) else {
                throw .unknown(range: node.range)
            }
            
            switch child.nodeType {
            case "text_arg_fragment":
                let fragment = try textFragment(from: child)
                value.append(fragment)
                
            default:
                throw .unknown(range: child.range)
            }
        }
        
        return CaptionModifier(
            value: value,
            range: node.range
        )
    }
}
