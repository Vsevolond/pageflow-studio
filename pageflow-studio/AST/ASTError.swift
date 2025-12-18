//
//  ASTError.swift
//  pageflow-studio
//
//  Created by Vsevolod Donchenko on 17.12.2025.
//

import Foundation

enum ASTError: Error {
    case unknown(file: FileName)
    case invalid(expression: Expression)
    case invalidAdd(operation: AddOperation)
    case invalidMul(operation: MulOperation)
}
