//
//  BaseContent-Render.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 27.02.2026.
//

import SwiftUI

extension BaseContent {
    
    @ViewBuilder
    func render(
        context: Axis,
        images: [(String, NSImage)],
        listings: [(String, String)]
    ) -> some View {
        switch self {
        case .vstack(let vStackBlock):
            vStackBlock.render(images: images, listings: listings)
            
        case .hstack(let hStackBlock):
            hStackBlock.render(images: images, listings: listings)
            
        case .zstack(let zStackBlock):
            zStackBlock.render(context: context, images: images, listings: listings)
            
        case .text(let textBlock):
            textBlock.render()
            
        case .math(let mathBlock):
            mathBlock.render()
            
        case .image(let imageElement):
            imageElement.render(images: images)
            
        case .spacer(let spacerElement):
            spacerElement.render()
            
        case .divider(let dividerElement):
            dividerElement.render(axis: context)
            
        case .listing(let listingElement):
            listingElement.render(listings: listings)
            
        case .rawText(let textContent):
            textContent.render()
            
        case .rawMath(let mathContent):
            mathContent.render()
        }
    }
}
