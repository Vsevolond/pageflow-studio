//
//  Theme.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 02.12.2025.
//

import SwiftUI

struct Theme {
    
    // MARK: - Internal Properties
    
    let colors: Colors
    
    // MARK: - Internal Methods
    
    func color(for token: String) -> Color? {
        colors.color(for: token)
    }

    // MARK: - Type Entities
    
    struct Colors {
        
        // MARK: - Internal Properties
        
        let colors: [String: Color]
        
        // MARK: - Internal Methods
        
        func color(for token: String) -> Color? {
            colors[token]
        }
    }
}

// MARK: - Extensions

extension Theme {
    
    // MARK: - Type Properties
    
    static let light = Theme(
        colors: Colors(
            colors: [
                "contentKeyword" : .pageflow.light.violet,
                "typeKeyword" : .pageflow.light.violet,
                "modifierKeyword" : .pageflow.light.lightViolet,
                "valueKeyword" : .pageflow.light.lightViolet,
                "boolean" : .pageflow.light.pink,
                "number" : .pageflow.light.blue,
                "constant" : .pageflow.light.teal,
                "operation" : .pageflow.light.black,
                "symbol" : .pageflow.light.black,
                "text" : .pageflow.light.black,
                "math" : .pageflow.light.red,
                "filename" : .pageflow.light.green,
                "newline" : .pageflow.light.cyan
            ]
        )
    )
    
    static let dark = Theme(
        colors: Colors(
            colors: [
                "contentKeyword" : .pageflow.dark.lightViolet,
                "typeKeyword" : .pageflow.dark.lightViolet,
                "modifierKeyword" : .pageflow.dark.violet,
                "valueKeyword" : .pageflow.dark.violet,
                "boolean" : .pageflow.dark.pink,
                "number" : .pageflow.dark.yellow,
                "constant" : .pageflow.dark.cyan,
                "operation" : .pageflow.dark.white,
                "symbol" : .pageflow.dark.white,
                "text" : .pageflow.dark.white,
                "math" : .pageflow.dark.red,
                "filename" : .pageflow.dark.lightGreen,
                "newline" : .pageflow.dark.blue
            ]
        )
    )
}
