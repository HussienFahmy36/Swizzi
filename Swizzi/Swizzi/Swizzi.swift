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
    internal var donwloadOperations: [Operation] = []
    internal var queue = OperationQueue()
    //MARK: - framework API
    init(with configurationFileBundle: Bundle) {
        configureFromFile(with: configurationFileBundle)
    }

    public func downloadAsync(from url: URL,  completionHandler: @escaping (Data?, SwizziError?)->()) -> Int {
        if let cachedData = cachedData(with: url) {
            if let expired = isExpired(url: url), !expired {
                completionHandler(cachedData, nil)
            }
        } else {
            let operation = DownloadOperation(url: url) { (data, error) in
                if error != nil {
                    completionHandler(nil, error)
                    return
                }
                if let cacheError = self.cacheFile(with: data, url: url) {
                    completionHandler(nil, cacheError)
                } else {
                    completionHandler(data, nil)
                }
            }
            queue.addOperation(operation)
            return operation.operationID
        }
        return 0
    }

    public func cancelDownload(operationID: Int) {
        if let operation = queue.operations.filter({($0 as? DownloadOperation)?.operationID == operationID}).first {
            operation.cancel()
        }
    }

    public func downloadSync(from url: URL, needsChecks: Bool = true) -> (Data?, SwizziError?) {
        if let cachedData = cachedData(with: url) {
            if let expired = isExpired(url: url), !expired {
                return (cachedData, nil)
            }
        } else {
            let data = dataLoader.loadDataSync(from: url)
            if !needsChecks {
                return cacheWithoutChecks(with: data, url: url) ? (data, nil) : (nil, nil)
            } else {
                if let error = cacheFile(with: data, url: url) {
                    return (nil, error)
                }
                else {
                    return (data, nil)
                }
            }
        }
        return (nil, nil)
    }
}
