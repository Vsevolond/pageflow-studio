//
//  AxisType.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 07.12.2025.
//

import SwiftUI

struct AxisType: ASTNode {
    
    // MARK: - Type Entities
    
    enum Value: String {
        case vertical, horizontal
    }
    
    // MARK: - Internal Properties
    
    let value: Value
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        /// not required
    }
}

// MARK: - Extensions

extension AxisType {
    
    var rawValue: Axis {
        switch value {
        case .vertical:
            return .vertical
            
        case .horizontal:
            return .horizontal
        }
    }
}
