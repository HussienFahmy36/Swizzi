//
//  SwizziErrorProtocol.swift
//  Swizzi
//
//  Created by Hussien Gamal Mohammed on 5/25/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import Foundation
protocol SwizziErrorProtocol: LocalizedError {

    var title: ErrorMessages { get }
    var code: ErrorCodes { get }
}
