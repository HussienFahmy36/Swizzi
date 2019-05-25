//
//  Swizzi.swift
//  Swizzi
//
//  Created by Hussien Gamal Mohammed on 5/20/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import Foundation


class Swizzi {

    internal let dataLoader = SwizziDataLoader()
    internal let cache = SwizziCache()
    internal let parser = SwizziJsonParser()
    internal var configuration: SwizziConfiguration?
    internal var cachedItemsKeys: [String: Int] = [:]

    //MARK: - framework API
    init(with configurationFileBundle: Bundle) {
        configureFromFile(with: configurationFileBundle)
    }

    public func downloadAsync(from url: URL,  completionHandler: @escaping (Data?)->()) {
        if let cachedData = cachedData(with: url) {
            if let expired = isExpired(url: url), !expired {
                completionHandler(cachedData)
            }
        } else {
            dataLoader.loadDataAsync(from: url) {[weak self] (data) in
                guard let `self` = self else {
                    completionHandler(nil)
                    return
                }
                if self.cacheFile(with: data, url: url) {
                    completionHandler(data)
                } else {
                    completionHandler(nil)
                }
                self.dataLoader.clearCache()
            }
        }

    }

    public func downloadSync(from url: URL) -> Data? {
        if let cachedData = cachedData(with: url) {
            if let expired = isExpired(url: url), !expired {
                return cachedData
            }
        }
        else {
            let data = dataLoader.loadDataSync(from: url)
            if cacheFile(with: data, url: url) {
                dataLoader.clearCache()
                return data
            }
        }
        return nil
    }
}
