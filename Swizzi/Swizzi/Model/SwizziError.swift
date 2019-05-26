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
    404 url not found
 */

public enum ErrorMessages: String {
    case parse = "Parse error"
    case runtime = "Runtime error"
    case dataIsNil = "Data is nil"
    case fileSizeExceedsLimit = "file size exceeds limit"
    case cacheIsFull = "cache is full"
    case maxNumberOfFilesReached = "cached files number exceeds limit"
    case urlNotFound = "Url not found"
    case noResponse = "No response from server"
}

public enum ErrorCodes: Int {
    case parse = 100
    case runtime = 103
    case dataIsNil = 110
    case fileSizeExceedsLimit = 210
    case cacheIsFull = 220
    case maxNumberOfFilesReached = 230
    case urlNotFound = 404
    case noResponse = 240
}
public struct SwizziError: SwizziErrorProtocol {
    public var title: ErrorMessages
    public var code: ErrorCodes
}
