//
//  SwizziFileManagerTests.swift
//  SwizziTests
//
//  Created by Hussien Gamal Mohammed on 5/24/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import XCTest

class SwizziFileManagerTests: XCTestCase {

    let fileManager = SwizziFileManager()

    override func setUp() {
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testsLoadJsonWithURLWithValidSize() {
        let expectation = self.expectation(description: "Loading sample file async")
        let sampleURLPath = "https://file-examples.com/wp-content/uploads/2017/02/file-sample_1MB.docx"
        fileManager.loadFile(from: URL(string: sampleURLPath)!, maxSizeInMB: 2) { (dataRecived) in
            XCTAssertNotNil(dataRecived)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)

    }

    func testsLoadJsonWithURLWithInValidSize() {
        let expectation = self.expectation(description: "Loading sample file async")
        let sampleURLPath = "http://mirrors.standaloneinstaller.com/video-sample/video-sample.m4v"
        fileManager.loadFile(from: URL(string: sampleURLPath)!, maxSizeInMB: 3) { (dataRecived) in
            XCTAssertNotNil(dataRecived, "File size exceeded max")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)

    }
}
