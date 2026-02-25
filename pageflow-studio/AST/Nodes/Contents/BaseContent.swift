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
    case rawText(TextContent)
    case rawMath(MathContent)
    
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
            
        case .rawText(let textContent):
            textContent.range
            
        case .rawMath(let mathContent):
            mathContent.range
        }
    }
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        switch self {
        case .vstack(let vStackBlock):
            try vStackBlock.validate(with: storage)
            
        case .hstack(let hStackBlock):
            try hStackBlock.validate(with: storage)
            
        case .zstack(let zStackBlock):
            try zStackBlock.validate(with: storage)
            
        case .text(let textBlock):
            try textBlock.validate(with: storage)
            
        case .math(let mathBlock):
            try mathBlock.validate(with: storage)
            
        case .image(let imageElement):
            try imageElement.validate(with: storage)
            
        case .spacer(let spacerElement):
            try spacerElement.validate(with: storage)
            
        case .divider(let dividerElement):
            try dividerElement.validate(with: storage)
            
        case .listing(let listingElement):
            try listingElement.validate(with: storage)
            
        case .rawText(let textContent):
            try textContent.validate(with: storage)
            
        case .rawMath(let mathContent):
            try mathContent.validate(with: storage)
        }
    }
}
