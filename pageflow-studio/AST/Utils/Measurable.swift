//
//  Measurable.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 17.12.2025.
//

import Foundation

protocol Measurable {
    
    // MARK: - Internal Properties
    
    var isMeasured: Bool { get }
    var points: CGFloat { get }
}
