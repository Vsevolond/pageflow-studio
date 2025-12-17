//
//  Constant-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 15.12.2025.
//

import SwiftTreeSitter

extension ASTParser {
    
//
//    constant: $ => choice("@width", "@height")
//
    func constant(
        from node: Node
    ) throws(ASTParseError) -> Constant {
        guard let text = node.text,
              let value = Constant.Value(rawValue: text)
        else {
            throw .unknown(range: node.range)
        }
        
        return Constant(
            value: value,
            range: node.range
        )
    }
}
