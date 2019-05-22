//
//  SwizziCacheHandler.swift
//  Swizzi
//
//  Created by Hussien Gamal Mohammed on 5/22/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import Foundation

class SwizziCacheManager {

    let dataLoader = SwizziDataLoader()
    let cache = SwizziCache()
    var cachedItemsKeys: [String: Int] = [:]
    
    func cache(url: URL, isAsync: Bool = true, completionHandler: @escaping (Bool)->()) {

        if cachedItemsKeys[url.absoluteString] == nil {
            if isAsync {
                dataLoader.loadDataAsync(from: url) { [weak self] (data) in
                    guard let `self` = self else {
                        return
                    }
                    completionHandler(self.storeInMemory(data: data,
                                                         urlString: url.absoluteString))
                }
            } else {
                let data = dataLoader.loadDataSync(from: url)
                completionHandler(storeInMemory(data: data,
                                                urlString: url.absoluteString))
            }
        }
    }

    func storeInMemory(data: Data?, urlString: String?) -> Bool{
        if let dataToStore = data, let urlToStore = urlString,
            let dataItemId = cache.cache(data: dataToStore) {
            cachedItemsKeys[urlToStore] = dataItemId
            return true
        }
        return false
    }

    func get(url: String) -> Data? {
        if let itemId = cachedItemsKeys[url] {
            return cache.get(itemId: itemId)
        }
        return nil
    }
}
