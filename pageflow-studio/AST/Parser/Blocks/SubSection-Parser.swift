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
//        repeat($.section_content),
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
        
        var content: [SectionBlock.Content] = []
        
        for index in 1..<node.namedChildCount {
            guard let child = node.namedChild(at: index) else {
                throw .unknown(range: node.range)
            }
            
            switch child.nodeType {
            case "section_content":
                let subSectionContent = try sectionContent(from: child)
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
}
