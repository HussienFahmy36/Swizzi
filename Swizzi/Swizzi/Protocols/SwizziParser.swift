//
//  SwizziParser.swift
//  Swizzi
//
//  Created by Hussien Gamal Mohammed on 5/25/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import Foundation

internal protocol SwizziParser {
    func parse<T: Codable>(data: Data?, to target: T.Type) -> T?

}
