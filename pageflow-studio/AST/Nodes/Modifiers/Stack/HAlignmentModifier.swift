//
//  HAlignmentModifier.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 09.12.2025.
//

import Foundation

struct HAlignmentModifier: ASTNode {
    
    // MARK: - Internal Properties
    
    let value: VerticalAlignmentType
    let range: NSRange
}
