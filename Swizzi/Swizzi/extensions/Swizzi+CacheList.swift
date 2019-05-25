//
//  Swizzi+URLOperations.swift
//  Swizzi
//
//  Created by Hussien Gamal Mohammed on 5/25/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import Foundation

extension Swizzi {

    internal func cacheFile(with data: Data?, url: URL) -> Bool {
        if cachedData(with: url) == nil {
            if isSizeAllowed(data: data) &&
                isCountAllowed() &&
                totalSizeAfterDataAdd(data: data) {
                if let cachedItem = cache.cache(data: data) {
                    cachedItemsKeys[url.absoluteString] = cachedItem.ID
                    return true
                }
            }
        }
        return false
    }

    internal func cachedData(with url: URL) -> Data? {
        if let itemId = cachedItemsKeys[url.absoluteString] {
            return cache.get(itemId: itemId)?.itemData
        }
        return nil
    }

    internal func removeFromCache(url: URL) -> Bool {
        if let itemId = cachedItemsKeys[url.absoluteString] {
            return cache.delete(itemId: itemId)
        }
        return false
    }

    //MARK: - configuration checks
    internal func isSizeAllowed(data: Data?) -> Bool {
        let dataSizeInMB = (data?.count ?? 0) / 1_024 / 1_024
        return (dataSizeInMB < (self.configuration?.maxFileSizeInMB ?? 0))
    }

    internal func isCountAllowed() -> Bool{
        return (cachedItemsKeys.count + 1) < configuration?.maxNumberOfFiles ?? 0
    }

    internal func totalSizeAfterDataAdd(data: Data?) -> Bool{
        let dataSizeInMB = (data?.count ?? 0) / 1_024 / 1_024
        return (dataSizeInMB + cache.cachedItemsSizeInMB()) < configuration?.totalSizeOfCacheInMB ?? 0
    }

    internal func isExpired(url: URL) -> Bool? {
        if let itemId = cachedItemsKeys[url.absoluteString] {
            if let item = cache.get(itemId: itemId),
                let configurationUnwrapped = configuration {
                    let calendar = Calendar.current
                    if let expirationDate = calendar.date(byAdding: .minute,
                                                       value: configurationUnwrapped.expiresInMinutes,
                                                       to: item.dateReceived), expirationDate < Date() {
                        return true
                    } else {
                        return false
                    }
            }
        }
        return nil
    }

}
