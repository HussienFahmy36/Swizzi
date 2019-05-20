//
//  ErrorHandler.swift
//  Swizzi
//
//  Created by Hussien Gamal Mohammed on 5/20/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import Foundation
enum ErrorType {
    case fileNotFound(path: String)
    case dataRetrivalError(filePath: String)
}

enum ErrorDescription: String {
    case fileNotFound = "File Not found"
    case dataRetrivalError = "Error in retriving data from file"

}

internal struct ErrorHandler {
    let componentErrorMessagePrefix: String = "Swizzi error:"
    func displayError(with type: ErrorType) {
        switch type {
        case .fileNotFound(path: ""): break

        default: break

        }
    }
}
