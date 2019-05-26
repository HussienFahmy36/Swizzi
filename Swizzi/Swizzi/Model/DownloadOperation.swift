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
    var operationIsExecuting: Bool = false
    override var isExecuting: Bool {
        return operationIsExecuting
    }

    init(url: URL, downloadCompleted: @escaping DownloadOperationCompletion) {
        self.url = url
        self.downloadCompleted = downloadCompleted
    }

    override func start() {
        super.start()
        guard let urlPassed = url else {
            return
        }
        dataLoader.loadDataAsync(from: urlPassed) {(data, error) in
            self.downloadCompleted(data,error)
            self.operationIsExecuting = false
        }

    }
    override func cancel() {
        operationIsExecuting = false
        super.cancel()
        dataLoader.cancelDownload()
    }


}
