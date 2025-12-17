//
//  CodeStyleType.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import Foundation

struct CodeStyleType: ASTNode {
    
    // MARK: - Type Entities
    
    enum Value: String {
        case manni, fruity, rrt, autumn, perldoc, bw, borland,
             emacs, colorful, vim, murphy, pastie, vs, friendly,
             trac, native, tango, monokai
    }
    
    // MARK: - Internal Properties
    
    let value: Value
    let range: NSRange
}
