//
//  VStack-Render.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 27.02.2026.
//

import SwiftUI

extension VStackBlock {
    
    @ViewBuilder
    func render(
        images: [(String, NSImage)],
        listings: [(String, String)]
    ) -> some View {
        VStackView(
            insets: parameters.insets,
            spacing: parameters.spacing,
            alignment: parameters.stackAlignment,
            backgroundColor: parameters.backgroundColor
        ) {
            ForEach(content, id: \.self) { content in
                content.render(
                    context: .vertical,
                    images: images,
                    listings: listings
                )
            }
            
        } caption: {
            if let caption = parameters.caption {
                TextMathView(
                    fragments: caption.fragments.rawValue,
                    textAlignment: .center,
                    lineSpacing: nil,
                    insets: .zero,
                    underline: nil,
                    strikethrough: nil,
                    fontSize: 10,
                    font: NSFont.latex(size: 10),
                    foregroundColor: .darkGray
                )
            }
        }
        .frame(
            width: parameters.width,
            height: parameters.height,
            alignment: parameters.alignment
        )
        .padding(parameters.padding)
        .offset(parameters.offset)
    }
}
