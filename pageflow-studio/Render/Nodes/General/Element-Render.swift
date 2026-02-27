//
//  Element-Render.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 26.02.2026.
//

import SwiftUI

extension Element {
    
    func render(
        parameters parametersOfPages: inout [DefaultPageView.Parameters],
        images: [(String, NSImage)],
        listings: [(String, String)]
    ) {
        switch self {
        case .newPage(let defaultNewPageBlock):
            defaultNewPageBlock.render(
                parameters: &parametersOfPages,
                images: images,
                listings: listings
            )
            
        case .section(let sectionBlock):
            sectionBlock.render(
                parameters: &parametersOfPages,
                images: images,
                listings: listings
            )
            
        case .content(let baseContent):
            guard let current = parametersOfPages.last else { return }
            
            let content = baseContent.render(context: .vertical, images: images, listings: listings)
            current.add { AnyView(content) }
        }
    }
}
