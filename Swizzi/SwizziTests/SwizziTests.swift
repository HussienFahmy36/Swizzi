//
//  SwizziTests.swift
//  SwizziTests
//
//  Created by Hussien Gamal Mohammed on 5/20/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import XCTest
@testable import Swizzi

class SwizziTests: XCTestCase {

    var swizzi: Swizzi?
    override func setUp() {
     swizzi = Swizzi(with: Bundle.init(for: self.classForCoder))

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testsDownloadSync() {
        let resultData = swizzi?.downloadSync(from: URL(string: "http://pastebin.com/raw/wgkJgazE")!)
        XCTAssertNotNil(resultData?.0)
        XCTAssert(resultData?.0?.count ?? 0 > 0, "Data received")
    }

    func testDownloadAsync() {
        let expectation = self.expectation(description: "Loading sample file async")
        swizzi?.downloadAsync(from: URL(string: "http://pastebin.com/raw/wgkJgazE")!, completionHandler: { (resultData, error) in
            expectation.fulfill()

            XCTAssertNotNil(resultData)
            XCTAssert(resultData?.count ?? 0 > 0, "Data received")
        })
        waitForExpectations(timeout: 30, handler: nil)
    }

    func DownloadAsyncExceedsMaxFileSize() {
        let expectation = self.expectation(description: "Loading sample file async")
        swizzi?.downloadAsync(from: URL(string: "https://www.hq.nasa.gov/alsj/a410/AS08_CM.PDF")!, completionHandler: { (resultData, error) in
            expectation.fulfill()

            XCTAssertNotNil(error)
            XCTAssert(resultData?.count == 0 , "No data")
            XCTAssertEqual(error?.code, .fileSizeExceedsLimit)
        })
        waitForExpectations(timeout: 150, handler: nil)

    }

    func testDownloadSyncTotalFilesCountExceedsMinimum() {
        _ = swizzi?.downloadSync(from: URL(string: "https://file-examples.com/wp-content/uploads/2017/02/file-sample_100kB.doc")!)
        _ = swizzi?.downloadSync(from: URL(string: "https://file-examples.com/wp-content/uploads/2017/02/file-sample_500kB.doc")!)
        _ = swizzi?.downloadSync(from: URL(string: "https://file-examples.com/wp-content/uploads/2017/02/file-sample_100kB.docx")!)
        _ = swizzi?.downloadSync(from: URL(string: "https://file-examples.com/wp-content/uploads/2017/02/file-sample_500kB.docx")!)
        _ = swizzi?.downloadSync(from: URL(string: "https://file-examples.com/wp-content/uploads/2017/02/file-sample_1MB.docx")!)
        let result = swizzi?.downloadSync(from: URL(string: "https://file-examples.com/wp-content/uploads/2017/02/file_example_XLS_50.xls")!)
        XCTAssertEqual(result?.1?.code, .maxNumberOfFilesReached)
    }

    func DownloadAsyncCacheIsFull() {
        let expectation = self.expectation(description: "Loading Large file")
        _ = swizzi?.downloadAsync(from: URL(string: "http://www.effigis.com/wp-content/uploads/2015/02/Infoterra_Terrasar-X_1_75_m_Radar_2007DEC15_Toronto_EEC-RE_8bits_sub_r_12.jpg")!, completionHandler: { (data, error) in
            expectation.fulfill()
            XCTAssertEqual(error?.code, .cacheIsFull)
        })
        waitForExpectations(timeout: 150, handler: nil)
    }

    func testDownloadAsyncDownloadCancelOperation1() {
        let expectation = self.expectation(description: "Loading Large file")
        let taskID = swizzi?.downloadAsync(from: URL(string: "https://file-examples.com/wp-content/uploads/2017/02/file-sample_100kB.docx")!, completionHandler: { (data, error) in
            expectation.fulfill()
            XCTAssertNotNil(data)
            XCTAssertNil(error)
        })
        waitForExpectations(timeout: 70, handler: nil)
    }

    func testDownloadAsyncDownloadOperation2() {
        let expectation = self.expectation(description: "Loading Large file")
        let taskID = swizzi?.downloadAsync(from: URL(string: "https://file-examples.com/wp-content/uploads/2017/02/file-sample_100kB.docx")!, completionHandler: { (data, error) in
            expectation.fulfill()
            XCTAssertNotNil(data)
            XCTAssertNil(error)
        })
        waitForExpectations(timeout: 70, handler: nil)
    }

    func testDownloadAsyncDownloadCancelOperation3Cancel() {
        let expectation = self.expectation(description: "Loading Large file")
        let taskID = swizzi?.downloadAsync(from: URL(string: "https://file-examples.com/wp-content/uploads/2017/02/file-sample_100kB.docx")!, completionHandler: { (data, error) in
            expectation.fulfill()

            XCTAssertNotNil(self.swizzi?.cachedData(with: URL(string: "https://file-examples.com/wp-content/uploads/2017/02/file-sample_100kB.docx")!))
            XCTAssertTrue(self.swizzi?.operationCancelled ?? false)
            XCTAssertEqual(error?.code, .dataIsNil)
        })
        self.swizzi?.cancelDownload(operationID: taskID!)
        waitForExpectations(timeout: 70, handler: nil)
    }

//    func testDownloadAsyncDownloadCancelOperationFromMultipleWithSameURL() {
//        let expectation = self.expectation(description: "Loading Large file")
//        let _ = swizzi?.downloadAsync(from: URL(string: "http://www.effigis.com/wp-content/uploads/2015/02/Infoterra_Terrasar-X_1_75_m_Radar_2007DEC15_Toronto_EEC-RE_8bits_sub_r_12.jpg")!, completionHandler: { (data, error) in
//            XCTAssertNotNil(data)
//            XCTAssertNil(error)
//        })
//
//        let _ = swizzi?.downloadAsync(from: URL(string: "http://www.effigis.com/wp-content/uploads/2015/02/Infoterra_Terrasar-X_1_75_m_Radar_2007DEC15_Toronto_EEC-RE_8bits_sub_r_12.jpg")!, completionHandler: { (data, error) in
//            XCTAssertNotNil(data)
//            XCTAssertNil(error)
//        })
//
//
//        let taskID3 = swizzi?.downloadAsync(from: URL(string: "http://www.effigis.com/wp-content/uploads/2015/02/Infoterra_Terrasar-X_1_75_m_Radar_2007DEC15_Toronto_EEC-RE_8bits_sub_r_12.jpg")!, completionHandler: { (data, error) in
//            expectation.fulfill()
//            XCTAssertTrue(self.swizzi?.operationCancelled ?? false)
//            XCTAssertEqual(error?.code, .dataIsNil)
//        })
//
//        self.swizzi?.cancelDownload(operationID: taskID3!)
//        waitForExpectations(timeout: 60, handler: nil)
//    }

}
