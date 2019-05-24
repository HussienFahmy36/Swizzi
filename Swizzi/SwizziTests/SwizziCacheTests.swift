//
//  SwizziCacheTests.swift
//  SwizziTests
//
//  Created by Hussien Gamal Mohammed on 5/24/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import XCTest

class SwizziCacheTests: XCTestCase {

    let cache = SwizziCache()

    func testCacheNilValue() {
        XCTAssertNil(cache.cache(data: nil))
    }
}
