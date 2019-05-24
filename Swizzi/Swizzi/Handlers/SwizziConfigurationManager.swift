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
    public var configuration: SwizziConfiguration = SwizziConfiguration()

    private init() {

    }

    public func configureFromFile(with bundle: Bundle) {
        let fileManager = SwizziFileManager()
        let configurationFile = "SwizziConfiguration"
        guard let filePath = bundle.path(forResource: configurationFile, ofType: "json") else {
            return
        }
        let fileURL = URL(fileURLWithPath: filePath)
        fileManager.loadJson(from: fileURL,isAsync: false, targetObject: SwizziConfiguration.self) {[weak self] (object) in
            guard let `self` = self else {
                return
            }
            if object != nil {
                self.configuration = object as! SwizziConfiguration
                return
            }
        }
    }
}
