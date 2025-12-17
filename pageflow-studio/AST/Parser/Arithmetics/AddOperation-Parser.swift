//
//  AddOperation-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
//
//    add_operation: $ => choice("+", "-")
//
    func addOperation(
        from node: Node
    ) throws(ASTParseError) -> AddOperation {
        guard let text = node.text,
              let value = AddOperation.Value(rawValue: text)
        else {
            throw .unknown(range: node.range)
        }
        
        return AddOperation(
            value: value,
            range: node.range
        )
    }
}
