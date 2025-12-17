//
//  Optional-Extension.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 03.12.2025.
//

import Foundation

extension Optional {
    
    // MARK: - Internal Methods
    
    func unwrap(or replacement: () -> Wrapped) -> Wrapped {
        if let wrapped = self {
            return wrapped
            
        } else {
            return replacement()
        }
    }
}
