//
//  FileName-Parser.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 17.12.2025.
//

import SwiftTreeSitter
import PageflowSourceEditor

extension ASTParserImpl {

//
//    file_name: $ => /[a-zA-Z0-9_\-]*/
//
    func fileName(
        from node: Node,
        type: FileName.Kind
    ) throws(ASTParseError) -> FileName {
        guard let value = controller.textView.substring(from: node.range) else {
            throw .unknown(range: node.range)
        }
        
        return FileName(
            type: type,
            value: value,
            range: node.range
        )
    }
}
