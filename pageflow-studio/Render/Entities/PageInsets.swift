//
//  PageInsets.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 26.02.2026.
//

import Foundation

struct PageInsets {
    let top: CGFloat?
    let bottom: CGFloat?
    let leading: CGFloat?
    let trailing: CGFloat?
}

// MARK: - Extensions

extension PageInsets {
    static let none = PageInsets(
        top: nil,
        bottom: nil,
        leading: nil,
        trailing: nil
    )
}
