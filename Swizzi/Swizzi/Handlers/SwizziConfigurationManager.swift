//
//  SwizziConfigurationManager.swift
//  Swizzi
//
//  Created by Hussien Gamal Mohammed on 5/21/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import Foundation

internal class SwizziConfigurationManager {

    static let shared = SwizziConfigurationManager()
    private var configuration: SwizziConfiguration = SwizziConfiguration()

    private init() {

    }

    private init(bundle: Bundle) {

    }

    public func configureFromFile(with bundle: Bundle) {
        let fileManager = SwizziDataLoader()
        let parseManager = SwizziParseManager()
        let configurationFile = "SwizziConfiguration"
        guard let data = fileManager.loadData(from: bundle,
                                              with: configurationFile,
                                              andExt: .json) else {
                                                return
        }
        guard let configurationFromFile = parseManager.parse(data: data,
                                                             to: SwizziConfiguration.self) else {
                                                                return
        }
        configuration = configurationFromFile
    }
}
