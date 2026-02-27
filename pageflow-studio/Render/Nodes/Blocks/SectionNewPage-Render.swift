//
//  SectionNewPage-Render.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 27.02.2026.
//

import SwiftUI

extension SectionNewPageBlock {
    
    func render(
        parameters parametersOfPages: inout [DefaultPageView.Parameters],
        images: [(String, NSImage)],
        listings: [(String, String)]
    ) {
        var contents: [AnyView] = []
        var isEnded = false
        
        for content in self.content {
            switch content {
            case .subSection(let subSectionBlock):
                if !isEnded {
                    isEnded = true
                    
                    guard let last = parametersOfPages.last else {
                        return
                    }
                    
                    let new = DefaultPageView.Parameters(insets: last.insets)
                    new.add(contentsOf: contents)
                    
                    parametersOfPages.append(new)
                    contents = []
                }
                
                subSectionBlock.render(
                    parameters: &parametersOfPages,
                    images: images,
                    listings: listings
                )
                
            case .content(let baseContent):
                if isEnded {
                    guard let current = parametersOfPages.last else { return }
                    
                    let content = baseContent.render(context: .vertical, images: images, listings: listings)
                    current.add { AnyView(content) }
                    
                } else {
                    let content = baseContent.render(context: .vertical, images: images, listings: listings)
                    contents.append(AnyView(content))
                }
            }
        }
    }
}
