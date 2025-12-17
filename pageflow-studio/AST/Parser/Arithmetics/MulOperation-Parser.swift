//
//  MulOperation-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
//
//    mul_operation: $ => choice("*", "/")
//
    func mulOperation(
        from node: Node
    ) throws(ASTParseError) -> MulOperation {
        guard let text = node.text,
              let value = MulOperation.Value(rawValue: text)
        else {
            throw .unknown(range: node.range)
        }
        
        return MulOperation(
            value: value,
            range: node.range
        )
    }
}
