//
//  MathFragment.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 06.12.2025.
//

import Foundation

struct MathFragment: ASTNode {
    
    // MARK: - Type Entities
    
    enum Value: Equatable, Hashable {
        case mathText(String)
        case newline
    }
    
    // MARK: - Internal Properties
    
    let value: Value
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        /// not required
    }
}

// MARK: - Extensions

extension Array where Element == MathFragment {
    
    var rawValue: [TextMathView.Fragment] {
        var fragments: [TextMathView.Fragment] = []
        
        for fragment in self {
            switch fragment.value {
            case .mathText(let string):
                fragments.append(.math(string))
                
            case .newline:
                fragments.append(.text("\n"))
            }
        }
        
        return fragments
    }
}
