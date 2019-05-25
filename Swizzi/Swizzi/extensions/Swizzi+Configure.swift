//
//  Swizzi+Configure.swift
//  Swizzi
//
//  Created by Hussien Gamal Mohammed on 5/25/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import Foundation
extension Swizzi {

    internal func configureFromFile(with bundle: Bundle) {
        let configurationFile = "SwizziConfiguration"
        guard let filePath = bundle.path(forResource: configurationFile, ofType: "json") else {
            return
        }
        let fileURL = URL(fileURLWithPath: filePath)
        let swizziJsonParser = SwizziJsonParser()
        let result = downloadSync(from: fileURL, needsChecks: false)
        if result.0 != nil {
            configuration = swizziJsonParser.parse(data: result.0, to: SwizziConfiguration.self)
        }
    }
}
