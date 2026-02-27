//
//  Spacer-Render.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 27.02.2026.
//

import SwiftUI

extension SpacerElement {
    
    @ViewBuilder
    func render() -> some View {
        Spacer(minLength: value?.points)
    }
}
