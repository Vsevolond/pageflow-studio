//
//  BaseContent.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 09.12.2025.
//

import Foundation

enum BaseContent: ASTNode {
    
    // MARK: - Cases
    
    case vstack(VStackBlock)
    case hstack(HStackBlock)
    case zstack(ZStackBlock)
    case text(TextBlock)
    case math(MathBlock)
    case image(ImageElement)
    case spacer(SpacerElement)
    case divider(DividerElement)
    case listing(ListingElement)
    
    // MARK: - Internal Properties
    
    var range: NSRange {
        switch self {
        case .vstack(let vStackBlock):
            vStackBlock.range
            
        case .hstack(let hStackBlock):
            hStackBlock.range
            
        case .zstack(let zStackBlock):
            zStackBlock.range
            
        case .text(let textBlock):
            textBlock.range
            
        case .math(let mathBlock):
            mathBlock.range
            
        case .image(let imageElement):
            imageElement.range
            
        case .spacer(let spacerElement):
            spacerElement.range
            
        case .divider(let dividerElement):
            dividerElement.range
            
        case .listing(let listingElement):
            listingElement.range
        }
    }
}
