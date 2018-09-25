//
//  SymbolsTests.swift
//  JSONtoCodable
//
//  Created by Yuto Mizutani on 2018/09/25.
//

import XCTest
@testable import JSONtoCodable

class SymbolsTests: XCTestCase {
    var base: JSONtoCodable!

    override func setUp() {
        super.setUp()
        self.base = JSONtoCodable()
    }

    func testAtSign() {
        let json: String = """
        {
            "@hello": "Hello, world!!"
        }
        """
        let expectation: String = """
        struct Result: Codable {
            let hello: String

            private enum CodingKeys: String, CodingKey {
                case hello = "@hello"
            }
        }
        """
        let result: String? = try? self.base.generate(json)
        XCTAssertEqual(result, expectation)
    }

    func testUnderScore() {
        let json: String = """
        {
            "_hello": "Hello, world!!"
        }
        """
        let expectation: String = """
        struct Result: Codable {
            let hello: String

            private enum CodingKeys: String, CodingKey {
                case hello = "_hello"
            }
        }
        """
        let result: String? = try? self.base.generate(json)
        XCTAssertEqual(result, expectation)
    }
}
