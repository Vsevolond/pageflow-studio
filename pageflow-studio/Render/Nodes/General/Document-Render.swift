//
//  Document-Render.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 26.02.2026.
//

import SwiftUI

extension Document {
    
    func render(
        images: [(String, NSImage)],
        listings: [(String, String)]
    ) -> [DefaultPageView] {
        var parameters = [DefaultPageView.Parameters()]
        
        for element in self.elements {
            element.render(
                parameters: &parameters,
                images: images,
                listings: listings
            )
        }
        
        let views = parameters.map { DefaultPageView(parameters: $0) }
        return views
    }
}
