//
//  SwizziCacheManager.swift
//  Swizzi
//
//  Created by Hussien Gamal Mohammed on 5/22/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import Foundation

struct DataItem {
    var itemData: Data?
    var ID: Int = 0
}

class SwizziCache {

    private var datatems: [DataItem] = []

    func cache(data: Data?) -> Int? {
        if data != nil {
            let randomId = Int.random(in: 0..<Int(RAND_MAX))
            let cacheItem = DataItem(itemData: data, ID: randomId)
            datatems.append(cacheItem)
            return randomId
        }
        return nil
    }

    func get(itemId: Int) -> Data? {
        return datatems.filter({$0.ID == itemId}).first?.itemData
    }
}

