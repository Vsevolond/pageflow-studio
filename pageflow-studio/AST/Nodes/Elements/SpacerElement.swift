//
//  SpacerElement.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 09.12.2025.
//

import Foundation

struct SpacerElement: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: Expression
    let range: NSRange
}
