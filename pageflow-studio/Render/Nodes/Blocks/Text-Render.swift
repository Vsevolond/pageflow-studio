//
//  Text-Render.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 27.02.2026.
//

import SwiftUI

extension TextBlock {
    
    @ViewBuilder
    func render() -> some View {
        content.render(with: parameters)
    }
}
