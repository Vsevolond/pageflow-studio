//
//  FileName-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 17.12.2025.
//

import SwiftTreeSitter

extension ASTParser {

//
//    file_name: $ => /[a-zA-Z0-9_\-]+/
//
    func fileName(
        from node: Node,
        type: FileName.Kind
    ) throws(ASTParseError) -> FileName {
        guard let text = node.text else {
            throw .unknown(range: node.range)
        }
        
        return FileName(
            type: type,
            value: text,
            range: node.range
        )
    }
}
