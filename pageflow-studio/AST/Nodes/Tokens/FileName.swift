//
//  FileName.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 12.12.2025.
//

import Foundation

struct FileName: ASTNode {
    
    // MARK: - Type Entities
    
    enum Kind {
        case image, listing
    }
    
    // MARK: - Internal Properties
    
    let type: Kind
    let value: String
    let range: NSRange
    
    // MARK: - Internal Methods
    
    func validate(with storage: ASTStorage) throws(ASTError) {
        switch type {
        case .image where !storage.contains(image: value):
            throw .unknown(file: self)
            
        case .listing where !storage.contains(listing: value):
            throw .unknown(file: self)
            
        default:
            return
        }
    }
}
