//
//  NSEdgeInsets-Extensions.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 27.02.2026.
//

import AppKit
import SwiftUI

extension NSEdgeInsets {
    
    static let zero = NSEdgeInsets(
        top: .zero,
        left: .zero,
        bottom: .zero,
        right: .zero
    )
    
    mutating func set(_ inset: CGFloat, for edge: Edge.Set) {
        if edge.contains(.top) {
            self.top = inset
        }
        
        if edge.contains(.bottom) {
            self.bottom = inset
        }
        
        if edge.contains(.leading) {
            self.left = inset
        }
        
        if edge.contains(.trailing) {
            self.right = inset
        }
    }
}
