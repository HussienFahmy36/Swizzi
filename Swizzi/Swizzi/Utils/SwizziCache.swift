//
//  SwizziCacheManager.swift
//  Swizzi
//
//  Created by Hussien Gamal Mohammed on 5/22/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import Foundation

struct CachableDataItem {
    var itemData: Data?
    var ID: Int = 0
    var dateReceived: Date
}

class SwizziCache {

    private var datatems: [CachableDataItem] = []

    func cache(data: Data?) -> CachableDataItem? {
        if data != nil {
            let randomId = Int.random(in: 0..<Int(RAND_MAX))
            let cacheItem = CachableDataItem(itemData: data, ID: randomId, dateReceived: Date())
            datatems.append(cacheItem)
            return cacheItem
        }
        return nil
    }

    func get(itemId: Int) -> CachableDataItem? {
        return datatems.filter({$0.ID == itemId}).first
    }

    func delete(itemId: Int) -> Bool {
        for (index, item) in datatems.enumerated() {
            if item.ID == itemId {
                datatems.remove(at: index)
                return true
            }
        }
        return false
    }

    func cachedItemsSizeInMB() -> Int {
        var size = 0
        for item in datatems {
            size += item.itemData?.count ?? 0
        }
        return size
    }
}

