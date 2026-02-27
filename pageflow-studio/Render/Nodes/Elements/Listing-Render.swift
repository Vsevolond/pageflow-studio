//
//  Listing-Render.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 27.02.2026.
//

import SwiftUI

extension ListingElement {
    
    @ViewBuilder
    func render(listings: [(name: String, listing: String)]) -> some View {
        if let (_, listing) = listings.first(where: { $0.name == name.value }) {
            let parameters = parameters
            
            ListingView(
                text: listing,
                language: parameters.language,
                style: parameters.style,
                frame: parameters.frame,
                numbers: parameters.numbers,
                fontSize: parameters.fontSize,
                font: parameters.font
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
        }
    }
}
