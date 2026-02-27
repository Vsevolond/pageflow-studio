//
//  EdgeInsets-Extensions.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 26.02.2026.
//

import SwiftUI

extension EdgeInsets {
    
    static let zero = EdgeInsets(
        top: .zero,
        leading: .zero,
        bottom: .zero,
        trailing: .zero
    )
    
    mutating func set(_ inset: CGFloat, for edge: Edge.Set) {
        if edge.contains(.top) {
            self.top = inset
        }
        
        if edge.contains(.bottom) {
            self.bottom = inset
        }
        
        if edge.contains(.leading) {
            self.leading = inset
        }
        
        if edge.contains(.trailing) {
            self.trailing = inset
        }
    }
}
