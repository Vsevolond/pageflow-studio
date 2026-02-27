//
//  TextContent-Render.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 26.02.2026.
//

import SwiftUI

extension TextContent {
    
    @ViewBuilder
    func render(with parameters: TextBlock.Parameters = .init()) -> some View {
        let view = TextMathView(
            fragments: fragments.rawValue,
            textAlignment: parameters.textAlignment,
            lineSpacing: parameters.lineSpacing,
            insets: .zero,
            underline: parameters.underline,
            strikethrough: parameters.strikethrough,
            fontSize: parameters.fontSize,
            font: parameters.font,
            foregroundColor: parameters.foregroundColor
        )
        
        textContentView(
            for: view,
            width: parameters.width,
            height: parameters.height,
            alignment: parameters.alignment,
            padding: parameters.padding,
            offset: parameters.offset
        )
    }
    
    @ViewBuilder
    private func textContentView(
        for view: TextMathView,
        width: CGFloat?,
        height: CGFloat?,
        alignment: Alignment,
        padding: EdgeInsets,
        offset: CGSize
    ) -> some View {
        view
            .frame(width: width, height: height, alignment: alignment)
            .padding(padding)
            .offset(offset)
    }
}
