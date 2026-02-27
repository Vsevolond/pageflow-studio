//
//  MathContent-Render.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 26.02.2026.
//

import SwiftUI

extension MathContent {
    
    @ViewBuilder
    func render(with parameters: MathBlock.Parameters = .init()) -> some View {
        let view = TextMathView(
            fragments: fragments.rawValue,
            textAlignment: parameters.textAlignment,
            lineSpacing: parameters.lineSpacing,
            insets: parameters.insets,
            underline: nil,
            strikethrough: nil,
            fontSize: parameters.fontSize,
            font: parameters.font,
            foregroundColor: parameters.foregroundColor
        )
        
        mathContentView(
            for: view,
            width: parameters.width,
            height: parameters.height,
            alignment: parameters.alignment,
            padding: parameters.padding,
            offset: parameters.offset
        )
    }
    
    @ViewBuilder
    private func mathContentView(
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
