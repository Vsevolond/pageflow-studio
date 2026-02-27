//
//  Image-Render.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 27.02.2026.
//

import SwiftUI

extension ImageElement {
    
    @ViewBuilder
    func render(images: [(name: String, image: NSImage)]) -> some View {
        if let (_, image) = images.first(where: { $0.name == name.value }) {
            let parameters = parameters
            
            let view = ImageView(
                image: image,
                width: parameters.width,
                height: parameters.height
            ) {
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
            
            imageElementView(
                for: view,
                padding: parameters.padding,
                offset: parameters.offset,
                alignment: parameters.alignment
            )
        }
    }
    
    @ViewBuilder
    private func imageElementView(
        for view: ImageView<TextMathView?>,
        padding: EdgeInsets,
        offset: CGSize,
        alignment: Alignment,
    ) -> some View {
        view
            .frame(alignment: alignment)
            .padding(padding)
            .offset(offset)
    }
}
