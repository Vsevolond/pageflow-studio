//
//  SubSection-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 13.12.2025.
//

import SwiftTreeSitter

extension ASTParserImpl {
    
//
//    subsection_block: $ => seq(
//        "SubSection",
//        "(",
//        $.text_content,
//        ")",
//        "{",
//        repeat($.subsection_content),
//        "}"
//    )
//
    func subSectionBlock(
        from node: Node
    ) throws(ASTParseError) -> SubSectionBlock {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        guard child.nodeType == "text_content" else {
            throw .unknown(range: child.range)
        }
        
        let title = try textContent(from: child)
        
        var content: [SubSectionBlock.Content] = []
        
        for index in 1..<node.namedChildCount {
            guard let child = node.namedChild(at: index) else {
                throw .unknown(range: node.range)
            }
            
            switch child.nodeType {
            case "subsection_content":
                let subSectionContent = try subSectionContent(from: child)
                content.append(subSectionContent)
                
            default:
                throw .unknown(range: child.range)
            }
        }
        
        return SubSectionBlock(
            title: title,
            content: content,
            range: node.range
        )
    }
    
//
//    subsection_content: $ => choice(
//        $.subsection_newpage_block,
//        $.content
//    )
//
    func subSectionContent(
        from node: Node
    ) throws(ASTParseError) -> SubSectionBlock.Content {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "subsection_newpage_block":
            let block = try subSectionNewPageBlock(from: child)
            return .newPage(block)
            
        case "content":
            let content = try content(from: child)
            return .content(content)
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//
//    subsection_newpage_block: $ => seq(
//        "NewPage",
//        "{",
//        repeat($.subsection_newpage_content),
//        "}",
//        repeat($.newpage_modifier)
//    )
//
    func subSectionNewPageBlock(
        from node: Node
    ) throws(ASTParseError) -> SubSectionNewPageBlock {
        var content: [SubSectionNewPageContent] = []
        var modifiers: [DefaultNewPageBlock.Modifier] = []
        
        for index in 0..<node.namedChildCount {
            guard let child = node.namedChild(at: index) else {
                throw .unknown(range: node.range)
            }
            
            switch child.nodeType {
            case "subsection_newpage_content":
                let sectionNewPageContent = try subSectionNewPageContent(from: child)
                content.append(sectionNewPageContent)
                
            case "newpage_modifier":
                let newPageModifier = try newPageModifier(from: child)
                modifiers.append(newPageModifier)
                
            default:
                throw .unknown(range: child.range)
            }
        }
        
        return SubSectionNewPageBlock(
            content: content,
            modifiers: modifiers,
            range: node.range
        )
    }
    
//
//    subsection_newpage_content: $ => $.content
//
    func subSectionNewPageContent(
        from node: Node
    ) throws (ASTParseError) -> SubSectionNewPageContent {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        guard child.nodeType == "content" else {
            throw .unknown(range: child.range)
        }
        
        let content = try content(from: child)
        return .content(content)
    }
}
