//
//  PageModifiers-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter

extension ASTParserImpl {
    
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
//        token.immediate("header"),
//        "(",
//        $.text_content,
//        ")"
//    )
//    
    func headerModifier(
        from node: Node
    ) throws(ASTParseError) -> HeaderModifier {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "text_content":
            let value = try textContent(from: child)
            
            return HeaderModifier(
                value: value,
                range: node.range
            )
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//    
//    footer_modifier: $ => seq(
//        token.immediate("footer"),
//        "(",
//        $.text_content,
//        ")"
//    )
//    
    func footerModifier(
        from node: Node
    ) throws(ASTParseError) -> FooterModifier {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "text_content":
            let value = try textContent(from: child)
            
            return FooterModifier(
                value: value,
                range: node.range
            )
            
        default:
            throw .unknown(range: child.range)
        }
    }
}
