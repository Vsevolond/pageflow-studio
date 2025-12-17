//
//  PageModifiers-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
//
//    page_modifiers: $ => choice(
//        $.header_modifier,
//        $.footer_modifier
//    )
//
    func pageModifiers(
        from node: Node
    ) throws(ASTParseError) -> PageModifiers {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "header_modifier":
            let modifier = try headerModifier(from: child)
            return .header(modifier)
            
        case "footer_modifier":
            let modifier = try footerModifier(from: child)
            return .footer(modifier)
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//    
//    header_modifier: $ => seq(
//        "header",
//        "(",
//        repeat($.text_arg_fragment),
//        ")"
//    )
//    
    func headerModifier(
        from node: Node
    ) throws(ASTParseError) -> HeaderModifier {
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
        
        return HeaderModifier(
            value: value,
            range: node.range
        )
    }
    
//    
//    footer_modifier: $ => seq(
//        "footer",
//        "(",
//        repeat($.text_arg_fragment),
//        ")"
//    )
//    
    func footerModifier(
        from node: Node
    ) throws(ASTParseError) -> FooterModifier {
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
        
        return FooterModifier(
            value: value,
            range: node.range
        )
    }
}
