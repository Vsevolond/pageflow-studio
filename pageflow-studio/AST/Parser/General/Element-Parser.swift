//
//  Element-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 13.12.2025.
//

import SwiftTreeSitter

extension ASTParserImpl {
    
//
//    element: $ => choice(
//        $.newpage_block,
//        $.section_block,
//        $.content
//    )
//
    func element(
        from node: Node
    ) throws(ASTParseError) -> Element {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "newpage_block":
            let block = try newPageBlock(from: child)
            return .newPage(block)
            
        case "section_block":
            let block = try sectionBlock(from: child)
            return .section(block)
            
        case "content":
            let content = try content(from: child)
            return .content(content)
            
        default:
            throw .unknown(range: child.range)
        }
    }
}
