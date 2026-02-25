//
//  NewPage-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 13.12.2025.
//

import SwiftTreeSitter

extension ASTParserImpl {
    
//
//    newpage_block: $ => seq(
//        "NewPage",
//        "{",
//        repeat($.newpage_content),
//        "}",
//        repeat($.newpage_modifier)
//    )
//
    func newPageBlock(
        from node: Node
    ) throws(ASTParseError) -> DefaultNewPageBlock {
        var content: [DefaultNewPageContent] = []
        var modifiers: [DefaultNewPageBlock.Modifier] = []
        
        for index in 0..<node.namedChildCount {
            guard let child = node.namedChild(at: index) else {
                throw .unknown(range: node.range)
            }
            
            switch child.nodeType {
            case "newpage_content":
                let newPageContent = try newPageContent(from: child)
                content.append(newPageContent)
                
            case "newpage_modifier":
                let newPageModifier = try newPageModifier(from: child)
                modifiers.append(newPageModifier)
                
            default:
                throw .unknown(range: child.range)
            }
        }
        
        return DefaultNewPageBlock(
            content: content,
            modifiers: modifiers,
            range: node.range
        )
    }
    
//
//    newpage_content: $ => choice(
//        $.section_block,
//        $.content
//    )
//
    func newPageContent(
        from node: Node
    ) throws(ASTParseError) -> DefaultNewPageContent {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
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
    
//
//    newpage_modifier: $ => seq(
//        ".",
//        choice(
//            $.page_modifiers,
//            $.inset_modifiers
//        )
//    )
//
    func newPageModifier(
        from node: Node
    ) throws(ASTParseError) -> DefaultNewPageBlock.Modifier {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "page_modifiers":
            let modifier = try pageModifiers(from: child)
            return .page(modifier)
            
        case "inset_modifiers":
            let modifier = try insetModifiers(from: child)
            return .inset(modifier)
            
        default:
            throw .unknown(range: child.range)
        }
    }
}
