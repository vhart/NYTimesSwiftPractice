//
//  AFWrapperTests.swift
//  PracticeApp
//
//  Created by Varindra Hart on 1/14/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

import XCTest
import Alamofire
@testable import PracticeApp

class AFWrapperTests: XCTestCase {

    var json: AnyObject?
    var books: [Books]?

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testGetJSONFromAPI() {
        let asyncExpectation = expectationWithDescription("longRunning")

        AFWrapper.getJSONFromAPI {
            (dict : Dictionary<String,AnyObject>) in
                self.json = dict
            
            asyncExpectation.fulfill()
        }

        self.waitForExpectationsWithTimeout(5) { error in
            XCTAssertNotNil(self.json)
        }
    }

    func testGetBooksFromJSON() {

        let asyncExpectation = expectationWithDescription("asyncOperationToClosure")

        AFWrapper.getJSONFromAPI { (dict: Dictionary<String,AnyObject>) in
           self.books = Books.booksFromJSON(dict)
            asyncExpectation.fulfill()
        }

        self.waitForExpectationsWithTimeout(5) { error in
            XCTAssert(self.books?.count > 0)
        }
    }
}
