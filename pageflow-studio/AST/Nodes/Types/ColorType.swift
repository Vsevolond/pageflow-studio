//
//  ColorType.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import AppKit
import PageflowSourceEditor

struct ColorType: ASTNode {
    
    // MARK: - Type Entities
    
    enum Value: String {
        case red, green, blue, cyan, magenta, yellow,
             black, gray, white, darkGray, lightGray, brown,
             lime, olive, orange, pink, purple, teal, violet
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

extension ColorType {
    
    var rawValue: NSColor {
        switch value {
        case .red:
            return NSColor(hex: "EA3323")
            
        case .green:
            return NSColor(hex: "75FB4C")
            
        case .blue:
            return NSColor(hex: "0600F5")
            
        case .cyan:
            return NSColor(hex: "48A0D5")
            
        case .magenta:
            return NSColor(hex: "C62F7C")
            
        case .yellow:
            return NSColor(hex: "FDF150")
            
        case .black:
            return NSColor(hex: "000000")
            
        case .gray:
            return NSColor(hex: "808080")
            
        case .white:
            return NSColor(hex: "FFFFFF")
            
        case .darkGray:
            return NSColor(hex: "404040")
            
        case .lightGray:
            return NSColor(hex: "BFBFBF")
            
        case .brown:
            return NSColor(hex: "B6824B")
            
        case .lime:
            return NSColor(hex: "CCFD51")
            
        case .olive:
            return NSColor(hex: "87832F")
            
        case .orange:
            return NSColor(hex: "EF8733")
            
        case .pink:
            return NSColor(hex: "F5C1C0")
            
        case .purple:
            return NSColor(hex: "AF2343")
            
        case .teal:
            return NSColor(hex: "377E7F")
            
        case .violet:
            return NSColor(hex: "75157C")
        }
    }
}
