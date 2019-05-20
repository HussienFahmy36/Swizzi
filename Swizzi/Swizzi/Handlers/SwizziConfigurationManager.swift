//
//  SwizziConfigurationManager.swift
//  Swizzi
//
//  Created by Hussien Gamal Mohammed on 5/21/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import Foundation

internal class SwizziConfigurationManager {

    func configureFromFile(with bundle: Bundle) -> SwizziConfiguration?{

        let fileManager = SwizziFileManager()
        let parseManager = SwizziParseManager()
        let configurationFile = "SwizziConfiguration"
        guard let data = fileManager.loadData(from: bundle,
                                              with: configurationFile,
                                              andExt: .json) else {
                                                return nil
        }
        guard let configurationFromFile = parseManager.parse(data: data,
                                                             to: SwizziConfiguration.self) else {
                                                                return nil
        }
        return configurationFromFile
    }
}
