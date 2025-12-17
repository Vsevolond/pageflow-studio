//
//  VAlignmentModifier.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 09.12.2025.
//

import Foundation

struct VAlignmentModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: HorizontalAlignmentType
    let range: NSRange
}
