//
//  SwizziFileManager.swift
//  Swizzi
//
//  Created by Hussien Gamal Mohammed on 5/20/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import Foundation

internal enum FileType: String {
    case json = "json"
}
internal class SwizziDataLoader {

    func loadDataSync(from url: URL) -> Data? {
       return try? Data(contentsOf: url)
    }

    func loadDataAsync(from url: URL, dataReceived: @escaping (Data?) -> ()) {
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            dataReceived(data)
        }
        task.resume()
    }
}
