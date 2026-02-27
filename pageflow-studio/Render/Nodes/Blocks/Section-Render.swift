//
//  Section-Render.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 27.02.2026.
//

import SwiftUI

extension SectionBlock {
    
    func render(
        parameters parametersOfPages: inout [DefaultPageView.Parameters],
        images: [(String, NSImage)],
        listings: [(String, String)]
    ) {
        var contents: [AnyView] = []
        var isEnded = false
        
        for content in self.content {
            switch content {
            case .newPage(let sectionNewPageBlock):
                if !isEnded {
                    isEnded = true
                    
                    guard let current = parametersOfPages.last else { return }
                    
                    let view = sectionView(contents: contents)
                    current.add { AnyView(view) }
                    
                    contents = []
                }
                
                sectionNewPageBlock.render(
                    parameters: &parametersOfPages,
                    images: images,
                    listings: listings
                )
                
            case .subSection(let subSectionBlock):
                if !isEnded {
                    isEnded = true
                    
                    guard let current = parametersOfPages.last else { return }
                    
                    let view = sectionView(contents: contents)
                    current.add { AnyView(view) }
                    
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
    
    @ViewBuilder
    private func sectionView(contents: [AnyView]) -> some View {
        SectionView {
            ForEach(contents.indices, id: \.self) { index in
                contents[index]
            }
            
        } title: {
            let parameters = TextBlock.Parameters(
                fontSize: 17,
                font: NSFont.latex(size: 17, style: .bold)
            )
            
            title.render(with: parameters)
        }
    }
}
