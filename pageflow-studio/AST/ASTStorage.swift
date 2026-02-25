//
//  ASTStorage.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 17.12.2025.
//

import Foundation

struct ASTStorage {
    
    // MARK: - Internal Properties
    
    var images: Set<String>
    var listings: Set<String>
    
    // MARK: - Internal Methods
    
    func contains(image: String) -> Bool {
        images.contains(image)
    }
    
    func contains(listing: String) -> Bool {
        listings.contains(listing)
    }
}
