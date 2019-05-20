//
//  SwizziParsable.swift
//  Swizzi
//
//  Created by Hussien Gamal Mohammed on 5/20/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import Foundation

public protocol SwizziParsable {
    func parse(dictionary: [String: Any]) -> SwizziBaseModel?
}
