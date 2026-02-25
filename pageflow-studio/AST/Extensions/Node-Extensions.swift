//
//  Node-Extensions.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 25.02.2026.
//

import SwiftTreeSitter

extension Node {
    
    // MARK: - Internal Properties
    
    var firstNamedChild: Node? {
        namedChild(at: 0)
    }
}
