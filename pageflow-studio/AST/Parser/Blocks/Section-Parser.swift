//
//  Section-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 13.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
//
//    section_block: $ => seq(
//        "Section",
//        "(",
//        repeat($.text_arg_fragment),
//        ")",
//        "{",
//        repeat($.section_content),
//        "}"
//    )
//
    func sectionBlock(
        from node: Node
    ) throws(ASTParseError) -> SectionBlock {
        var title: [TextFragment] = []
        var content: [SectionBlock.Content] = []
        
        for index in 0..<node.namedChildCount {
            guard let child = node.namedChild(at: index) else {
                throw .unknown(range: node.range)
            }
            
            switch child.nodeType {
            case "text_arg_fragment":
                let fragment = try textFragment(from: child)
                title.append(fragment)
                
            case "section_content":
                let sectionContent = try sectionContent(from: child)
                content.append(sectionContent)
                
            default:
                throw .unknown(range: child.range)
            }
        }
        
        return SectionBlock(
            title: title,
            content: content,
            range: node.range
        )
    }
    
//
//    section_content: $ => choice(
//        $.section_newpage_block,
//        $.subsection_block,
//        $.content
//    )
//
    func sectionContent(
        from node: Node
    ) throws(ASTParseError) -> SectionBlock.Content {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "section_newpage_block":
            let block = try sectionNewPageBlock(from: child)
            return .newPage(block)
            
        case "subsection_block":
            let block = try subSectionBlock(from: child)
            return .subSection(block)
            
        case "content":
            let content = try content(from: child)
            return .content(content)
            
        default:
            throw .unknown(range: child.range)
        }
    }
    
//
//    section_newpage_block: $ => seq(
//        "NewPage",
//        "{",
//        repeat($.section_newpage_content),
//        "}",
//        repeat($.newpage_modifier)
//    )
//
    func sectionNewPageBlock(
        from node: Node
    ) throws(ASTParseError) -> SectionNewPageBlock {
        var content: [SectionNewPageContent] = []
        var modifiers: [DefaultNewPageBlock.Modifier] = []
        
        for index in 0..<node.namedChildCount {
            guard let child = node.namedChild(at: index) else {
                throw .unknown(range: node.range)
            }
            
            switch child.nodeType {
            case "section_newpage_content":
                let sectionNewPageContent = try sectionNewPageContent(from: child)
                content.append(sectionNewPageContent)
                
            case "newpage_modifier":
                let newPageModifier = try newPageModifier(from: child)
                modifiers.append(newPageModifier)
                
            default:
                throw .unknown(range: child.range)
            }
        }
        
        return SectionNewPageBlock(
            content: content,
            modifiers: modifiers,
            range: node.range
        )
    }
    
//
//    section_newpage_content: $ => choice(
//        $.subsection_block,
//        $.content
//    )
//
    func sectionNewPageContent(
        from node: Node
    ) throws(ASTParseError) -> SectionNewPageContent {
        guard let child = node.firstNamedChild else {
            throw .unknown(range: node.range)
        }
        
        switch child.nodeType {
        case "subsection_block":
            let block = try subSectionBlock(from: child)
            return .subSection(block)
            
        case "content":
            let content = try content(from: child)
            return .content(content)
            
        default:
            throw .unknown(range: child.range)
        }
    }
}
