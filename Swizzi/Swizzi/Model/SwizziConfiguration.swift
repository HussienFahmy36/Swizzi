//
//  SwizziConfiguration.swift
//  Swizzi
//
//  Created by Hussien Gamal Mohammed on 5/20/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import Foundation

internal class SwizziConfiguration: Codable {

    var maxNumberOfFiles: Int = 0
    var totalSizeOfCacheInMB: Int = 0
    var maxFileSizeInMB: Int = 0
    var expiresInMinutes: Int = 0
    var initialDataSource: String = ""
    var enablePullToRefreshAnimation: Bool = true
    var enableTransitionsAnimations: Bool = true
    

}
