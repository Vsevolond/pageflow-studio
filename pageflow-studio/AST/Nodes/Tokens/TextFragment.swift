//
//  TextFragment.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 06.12.2025.
//

import Foundation

struct TextFragment: ASTNode {
    
    // MARK: - Type Entities
    
    enum Value: Equatable, Hashable {
        case rawText(String)
        case rawMath(MathContent)
        case newline
    }
    
    // MARK: - Internal Properties
    
    let value: Value
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        guard case .rawMath(let mathContent) = value else {
            return
        }
        
        try mathContent.validate(with: storage)
    }
}

// MARK: - Extensions

extension Array where Element == TextFragment {
    
    var rawValue: [TextMathView.Fragment] {
        var fragments: [TextMathView.Fragment] = []
        
        for fragment in self {
            switch fragment.value {
            case .rawText(let string):
                fragments.append(.text(string))
                
            case .rawMath(let content):
                fragments.append(contentsOf: content.fragments.rawValue)
                
            case .newline:
                fragments.append(.text("\n"))
            }
        }
        
        return fragments
    }
}
