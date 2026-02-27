//
//  CGSize-Extensions.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 27.02.2026.
//

import SwiftUI

extension CGSize {
    
    mutating func set(_ offset: CGFloat, for axis: Axis) {
        switch axis {
        case .horizontal:
            self.width = offset
            
        case .vertical:
            self.height = offset
        }
    }
}
