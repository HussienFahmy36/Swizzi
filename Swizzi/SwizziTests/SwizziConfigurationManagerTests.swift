//
//  SwizziConfigurationTests.swift
//  SwizziTests
//
//  Created by Hussien Gamal Mohammed on 5/21/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import XCTest

class SwizziConfigurationManagerTests: XCTestCase {

    let configurationManager = SwizziConfigurationManager.shared
    var configuredObject: SwizziConfiguration = SwizziConfiguration()

    override func setUp() {
        configurationManager.configureFromFile(with: Bundle.init(for: self.classForCoder))
        configuredObject = configurationManager.configuration

    }
    
    func testMaxNumberOfFiles() {
        XCTAssertEqual(configuredObject.maxNumberOfFiles, 100)
    }

    func testTotalSizeOfCacheInMB() {
        XCTAssertEqual(configuredObject.totalSizeOfCacheInMB, 100)
    }

    func testMaxFileSizeInMB() {
        XCTAssertEqual(configuredObject.maxFileSizeInMB, 20)
    }

    func testExpiresIn() {
        XCTAssertEqual(configuredObject.expiresInMinutes, 60)
    }

    func testInitialDataSource() {
        XCTAssertEqual(configuredObject.initialDataSource, "http://pastebin.com/raw/wgkJgazE")
    }

    func testEnablePullToRefreshAnimation() {
        XCTAssertEqual(configuredObject.enablePullToRefreshAnimation, true)
    }

    func testEnableTransitionsAnimations() {
        XCTAssertEqual(configuredObject.enableTransitionsAnimations, true)
    }



}
