//
//  Document-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 13.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
//
//    source_file: $ => repeat($.element)
//
    func document(
        from node: Node
    ) throws(ASTParseError) -> Document {
        var elements: [Element] = []
        
        for index in 0..<node.namedChildCount {
            guard let child = node.namedChild(at: index) else {
                throw .unknown(range: node.range)
            }
            
            guard child.nodeType == "element" else {
                throw .unknown(range: child.range)
            }
            
            let element = try element(from: child)
            elements.append(element)
        }
        
        return Document(elements: elements, range: node.range)
    }
}
