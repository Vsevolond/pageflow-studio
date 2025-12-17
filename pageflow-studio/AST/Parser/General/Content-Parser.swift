//
//  Content-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 13.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
//
//    content: $ => choice(
//        $.vstack_block,
//        $.hstack_block,
//        $.zstack_block,
//        $.text_block,
//        $.math_block,
//        $.image_element,
//        $.spacer_element,
//        $.divider_element,
//        $.listing_element
//    )
//
    func content(
        from node: Node
    ) throws(ASTParseError) -> BaseContent {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "vstack_block":
            let block = try vStackBlock(from: child)
            return .vstack(block)
            
        case "hstack_block":
            let block = try hStackBlock(from: child)
            return .hstack(block)
            
        case "zstack_block":
            let block = try zStackBlock(from: child)
            return .zstack(block)
            
        case "text_block":
            let block = try textBlock(from: child)
            return .text(block)
            
        case "math_block":
            let block = try mathBlock(from: child)
            return .math(block)
            
        case "image_element":
            let element = try imageElement(from: child)
            return .image(element)
            
        case "spacer_element":
            let element = try spacerElement(from: child)
            return .spacer(element)
            
        case "divider_element":
            let element = try dividerElement(from: child)
            return .divider(element)
            
        case "listing_element":
            let element = try listingElement(from: child)
            return .listing(element)
            
        default:
            throw .unknown(range: child.range)
        }
    }
}
