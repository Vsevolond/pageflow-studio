//
//  Validatable.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 18.12.2025.
//

import Foundation

protocol Validatable {
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError)
}
