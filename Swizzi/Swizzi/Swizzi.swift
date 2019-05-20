//
//  Swizzi.swift
//  Swizzi
//
//  Created by Hussien Gamal Mohammed on 5/20/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import Foundation


class Swizzi {

    var configuration = SwizziConfiguration()

    init(with configuration: SwizziConfiguration) {
        self.configuration = configuration
    }

    init(with bundle: Bundle) {
        guard let configurationFromFile = SwizziConfigurationManager().configureFromFile(with: bundle) else {
            return
        }
        configuration = configurationFromFile
    }
}
