//
//  SwizziFileManagerTests.swift
//  SwizziTests
//
//  Created by Hussien Gamal Mohammed on 5/22/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import XCTest

class SwizziDataLoaderTests: XCTestCase {

    let dataLoader = SwizziDataLoader()

    func testsLoadDataFromURLSync() {
        let urlString = "http://www.africau.edu/images/default/sample.pdf"
        guard let sampleURL = URL.init(string: urlString) else {
            XCTFail("URL not valid")
            return
        }
        XCTAssertNotNil(dataLoader.loadDataSync(from: sampleURL))
    }

    func testsLoadDataFromURLAsync() {
        let urlString = "http://www.africau.edu/images/default/sample.pdf"
        guard let sampleURL = URL.init(string: urlString) else {
            XCTFail("URL not valid")
            return
        }
        let expectation = self.expectation(description: "Loading sample file async")
        dataLoader.loadDataAsync(from: sampleURL) { (data) in
            expectation.fulfill()
            XCTAssertNotNil(data, "Loaded data is not nil")
            XCTAssertTrue(!data!.isEmpty, "Loaded sucesfully from sample url: \(urlString)")
        }
        waitForExpectations(timeout: 10, handler: nil)

    }

}
