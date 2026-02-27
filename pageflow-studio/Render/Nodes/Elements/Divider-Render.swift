//
//  Divider-Render.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 27.02.2026.
//

import SwiftUI

extension DividerElement {
    
    @ViewBuilder
    func render(axis: Axis) -> some View {
        divider(
            tint: parameters.foregroundColor,
            axis: axis
        )
        .frame(
            width: parameters.width,
            height: parameters.height,
            alignment: parameters.alignment
        )
        .padding(parameters.padding)
        .offset(parameters.offset)
    }
    
    @ViewBuilder
    private func divider(
        tint nsColor: NSColor?,
        axis: Axis
    ) -> some View {
        if let nsColor {
            let color = Color(nsColor: nsColor)
            
            switch axis {
            case .horizontal:
                Divider()
                    .frame(height: thickness?.points)
                    .overlay(color)
                
            case .vertical:
                Divider()
                    .frame(width: thickness?.points)
                    .overlay(color)
            }
            
        } else {
            switch axis {
            case .horizontal:
                Divider()
                    .frame(height: thickness?.points)
                
            case .vertical:
                Divider()
                    .frame(width: thickness?.points)
            }
        }
    }
}
