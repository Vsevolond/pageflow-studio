//
//  TextContent-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 26.02.2026.
//

import Foundation
import SwiftTreeSitter

extension ASTParserImpl {
    
//
//    text_content: $ => seq(
//        $.text_delimiter,
//        repeat($.text_fragment),
//        $.text_delimiter
//    )
//
    func textContent(
        from node: Node
    ) throws(ASTParseError) -> TextContent {
        var fragments: [TextFragment] = []
        
        for index in 0..<node.namedChildCount {
            guard let child = node.namedChild(at: index) else {
                throw .unknown(range: node.range)
            }
            
            switch child.nodeType {
            case "text_fragment":
                let fragment = try textFragment(from: child)
                
                if !fragment.isEmpty {
                    fragments.append(fragment)
                }
                
            case "text_delimiter":
                continue
                
            default:
                throw .unknown(range: child.range)
            }
        }
        
        return TextContent(
            fragments: fragments,
            range: node.range
        )
    }
}

// MARK: - Private Extensions

private extension TextFragment {
    
    // MARK: - Internal Properties
    
    var isEmpty: Bool {
        switch value {
        case .rawText(let string):
            return string.isEmpty
            
        case .rawMath(let mathContent):
            return mathContent.fragments.isEmpty
            
        case .newline:
            return false
        }
    }
}
