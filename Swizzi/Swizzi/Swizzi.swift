//
//  Swizzi.swift
//  Swizzi
//
//  Created by Hussien Gamal Mohammed on 5/20/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import Foundation


class Swizzi {
    
    init(with bundle: Bundle) {
        SwizziConfigurationManager.shared.configureFromFile(with: bundle)
    }
    
}
