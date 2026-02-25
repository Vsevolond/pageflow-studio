//
//  MathContent-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 26.02.2026.
//

import Foundation
import SwiftTreeSitter

extension ASTParserImpl {
    
//    
//    math_content: $ => seq(
//        $.math_delimiter,
//        repeat($.math_fragment),
//        $.math_delimiter
//    )
//
    func mathContent(
        from node: Node
    ) throws(ASTParseError) -> MathContent {
        var fragments: [MathFragment] = []
        
        for index in 0..<node.namedChildCount {
            guard let child = node.namedChild(at: index) else {
                throw .unknown(range: node.range)
            }
            
            switch child.nodeType {
            case "math_fragment":
                let fragment = try mathFragment(from: child)
                
                if !fragment.isEmpty {
                    fragments.append(fragment)
                }
                
            case "math_delimiter":
                continue
                
            default:
                throw .unknown(range: child.range)
            }
        }
        
        return MathContent(
            fragments: fragments,
            range: node.range
        )
    }
}

// MARK: - Private Extensions

private extension MathFragment {
    
    // MARK: - Internal Properties
    
    var isEmpty: Bool {
        switch value {
        case .mathText(let string):
            return string.isEmpty
            
        case .newline:
            return false
        }
    }
}
