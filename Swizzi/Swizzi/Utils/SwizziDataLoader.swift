//
//  SwizziFileManager.swift
//  Swizzi
//
//  Created by Hussien Gamal Mohammed on 5/20/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import Foundation

internal class SwizziDataLoader {

    private var session = URLSession()
    func loadDataSync(from url: URL) -> Data? {
       return try? Data(contentsOf: url)
    }

    func loadDataAsync(from url: URL, dataReceived: @escaping (Data?) -> ()) {
        let sessionConfig = URLSessionConfiguration.default
        session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let receivedData = data else {
                dataReceived(nil)
                return
            }
            let receivedDataAsString = receivedData.base64EncodedString()
            let receivedDataAfterConvert = Data(base64Encoded: receivedDataAsString)
            dataReceived(receivedDataAfterConvert)
        }
        task.resume()
    }

    func clearCache() {
        session.reset {
        }
    }
}
