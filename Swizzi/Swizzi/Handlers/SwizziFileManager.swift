//
//  SwizziCacheHandler.swift
//  Swizzi
//
//  Created by Hussien Gamal Mohammed on 5/22/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import Foundation

class SwizziFileManager {

    let dataLoader = SwizziDataLoader()
    let cache = SwizziCache()
    let parser = SwizziParser()

    var cachedItemsKeys: [String: Int] = [:]
    func load(from url: URL, completionHandler: @escaping (Data?)->()) {

    }

    func loadJson<T: Codable>(from url: URL,
                              isAsync: Bool = true,
                              targetObject: T.Type,
                              completionHandler: @escaping (Codable?)->()) {
        if !urlCached(url: url) {
            if isAsync {
                loadJsonAsync(from: url,
                              targetObject: targetObject,
                              completionHandler: completionHandler)
            }
            else {
                completionHandler(loadJsonSync(from: url,
                                               targetObject: targetObject))
            }
        }
        else {
            completionHandler(getCachedJson(from: url,
                                            targetObject: targetObject))
        }
    }

    func get(url: String) -> Data? {
        if let itemId = cachedItemsKeys[url] {
            return cache.get(itemId: itemId)
        }
        return nil
    }

    internal func storeInMemory(data: Data?, urlString: String?) -> Bool{
        if let dataToStore = data, let urlToStore = urlString,
            let dataItemId = cache.cache(data: dataToStore) {
            cachedItemsKeys[urlToStore] = dataItemId
            return true
        }
        return false
    }

    private func urlCached(url: URL) -> Bool {
        return (cachedItemsKeys[url.absoluteString] != nil)
    }
}
