//
//  NSFont-Extensions.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 26.02.2026.
//

import AppKit
import Rearrange

extension NSFont {
    
    static func latex(
        size: CGFloat,
        style: FontStyleType.Value = .medium
    ) -> NSFont {
        let baseDescriptor = NSFontDescriptor.preferredFontDescriptor(forTextStyle: .body)
        
        guard let serifDescriptor = baseDescriptor.withDesign(.serif),
              let serifFont = NSFont(descriptor: serifDescriptor, size: size)
        else {
            return NSFont.systemFont(ofSize: size)
        }
        
        switch style {
        case .medium:
            return serifFont
            
        case .bold:
            return NSFontManager.shared.convert(serifFont, toHaveTrait: .boldFontMask)
            
        case .italic:
            return NSFontManager.shared.convert(serifFont, toHaveTrait: .italicFontMask)
            
        case .smallCaps:
            return NSFontManager.shared.convert(serifFont, toHaveTrait: .smallCapsFontMask)
            
        case .monospaced:
            return NSFont.monospacedSystemFont(ofSize: size, weight: .regular)
        }
    }
}
