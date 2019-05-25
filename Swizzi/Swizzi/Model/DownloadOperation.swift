//
//  DownloadOperation.swift
//  Swizzi
//
//  Created by Hussien Gamal Mohammed on 5/25/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import Foundation
class DownloadOperation: Operation {
    public typealias DownloadOperationCompletion = (Data?, SwizziError?) -> ()

    internal let operationID: Int = {
        return  Int.random(in: 0..<Int(RAND_MAX))
    }()
    var url: URL?
    let dataLoader = SwizziDataLoader()
    var downloadCompleted: DownloadOperationCompletion

    init(url: URL, downloadCompleted: @escaping DownloadOperationCompletion) {
        self.url = url
        self.downloadCompleted = downloadCompleted
    }

    override func start() {
        super.main()
        guard let urlPassed = url else {
            return
        }
        dataLoader.loadDataAsync(from: urlPassed) {(data, error) in
            self.downloadCompleted(data,error)
        }

    }
    override func cancel() {
        super.cancel()
        dataLoader.cancelDownload()
    }
}
