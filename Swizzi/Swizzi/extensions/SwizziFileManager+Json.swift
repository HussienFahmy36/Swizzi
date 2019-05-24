//
//  SwizziFileManager+Json.swift
//  Swizzi
//
//  Created by Hussien Gamal Mohammed on 5/24/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import Foundation

extension SwizziFileManager {

    internal func loadJsonAsync<T: Codable>(from url: URL,targetObject: T.Type,
                                           completionHandler: @escaping (Codable?)->()) {
        dataLoader.loadDataAsync(from: url) { [weak self] (data) in
            guard let `self` = self else {
                return
            }
            if self.storeInMemory(data: data,
                                  urlString: url.absoluteString) {
                guard let object = self.parser.parse(data: data, to: targetObject) else{
                    return
                }
                completionHandler(object)
            }
            else {
                completionHandler(nil)
            }
        }
    }

    internal func loadJsonSync<T: Codable>(from url: URL,targetObject: T.Type) -> Codable? {
        guard let data = dataLoader.loadDataSync(from: url) else { return nil }
        if self.storeInMemory(data: data,
                              urlString: url.absoluteString) {
            let object = self.parser.parse(data: data, to: targetObject)
            return object
        }
        return nil
    }

    internal func getCachedJson<T: Codable>(from url: URL,targetObject: T.Type) -> Codable? {
        guard let data = get(url: url.absoluteString) else {
            return nil
        }
        let object = self.parser.parse(data: data, to: targetObject)
        return object

    }
}
