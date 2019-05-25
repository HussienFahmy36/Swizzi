//
//  SwizziErrorObjects.swift
//  Swizzi
//
//  Created by Hussien Gamal Mohammed on 5/25/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import Foundation
/*
 error codes list:
    100 parse error
    103 runtime error
    110 data is nil
    210 file size exceeds limit
    220 cache is full
    230 cache number of files exceeds limit
 */

enum ErrorMessages: String {
    case parse = "Parse error"
    case runtime = "Runtime error"
    case dataIsNil = "Data is nil"
    case fileSizeExceedsLimit = "file size exceeds limit"
    case cacheIsFull = "cache is full"
    case maxNumberOfFilesReached = "cached files number exceeds limit"
}

enum ErrorCodes: Int {
    case parse = 100
    case runtime = 103
    case dataIsNil = 110
    case fileSizeExceedsLimit = 210
    case cacheIsFull = 220
    case maxNumberOfFilesReached = 230
}
struct SwizziError: SwizziErrorProtocol {
    var title: ErrorMessages
    var code: ErrorCodes
}
