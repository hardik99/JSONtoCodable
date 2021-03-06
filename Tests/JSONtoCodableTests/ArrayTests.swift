//
//  ArrayTests.swift
//  JSONtoCodable
//
//  Created by Yuto Mizutani on 2018/09/23.
//

import XCTest
@testable import JSONtoCodable

class ArrayTests: XCTestCase {
    var base: JSONtoCodable!

    override func setUp() {
        super.setUp()
        self.base = JSONtoCodable()
    }

    func testRawEmptyArray() {
        let json: String = """
        {
            "a": []
        }
        """
        let expectation: String = """
        public struct Result: Codable {
            public let a: [Any]
        }
        """
        let result: String? = try? self.base.generate(json)
        XCTAssertEqual(result, expectation)
    }

    func testRawStringArray() {
        let json: String = """
        {
            "a": ["b", "c", "d"]
        }
        """
        let expectation: String = """
        public struct Result: Codable {
            public let a: [String]
        }
        """
        let result: String? = try? self.base.generate(json)
        XCTAssertEqual(result, expectation)
    }

    func testRawFormattedStringArray() {
        let json: String = """
        {
            "a": [
                    "b",
                    "c",
                    "d"
                ]
        }
        """
        let expectation: String = """
        public struct Result: Codable {
            public let a: [String]
        }
        """
        let result: String? = try? self.base.generate(json)
        XCTAssertEqual(result, expectation)
    }

    func testRawIntArray() {
        let json: String = """
        {
            "a": [1, 2, 3]
        }
        """
        let expectation: String = """
        public struct Result: Codable {
            public let a: [Int]
        }
        """
        let result: String? = try? self.base.generate(json)
        XCTAssertEqual(result, expectation)
    }

    func testRawFormattedIntArray() {
        let json: String = """
        {
            "a": [
                    1,
                    2,
                    3
                ]
        }
        """
        let expectation: String = """
        public struct Result: Codable {
            public let a: [Int]
        }
        """
        let result: String? = try? self.base.generate(json)
        XCTAssertEqual(result, expectation)
    }

    func testRawMultTypesArray() {
        let json: String = """
        {
            "a": ["b", 1, true, []]
        }
        """
        let expectation: String = """
        public struct Result: Codable {
            public let a: [Any]
        }
        """
        let result: String? = try? self.base.generate(json)
        XCTAssertEqual(result, expectation)
    }

    func testRawMultTypesWithNullArray() {
        let json: String = """
        {
            "a": ["b", 1, true, null]
        }
        """
        let expectation: String = """
        public struct Result: Codable {
            public let a: [Any?]
        }
        """
        let result: String? = try? self.base.generate(json)
        XCTAssertEqual(result, expectation)
    }

    func testRawFormattedMultTypesWithOojectArray() {
        let json: String = """
        {
            "a": [
                    "b",
                    {
                        "c": "d"
                    }
                ]
        }
        """
        let expectation: String = """
        public struct Result: Codable {
            public let a: [Any]
        }
        """
        let result: String? = try? self.base.generate(json)
        XCTAssertEqual(result, expectation)
    }

    func testRawFormattedMultTypesWithNullOojectArray() {
        let json: String = """
        {
            "a": [
                    "b",
                    null,
                    {
                        "c": "d"
                    }
                ]
        }
        """
        let expectation: String = """
        public struct Result: Codable {
            public let a: [Any?]
        }
        """
        let result: String? = try? self.base.generate(json)
        XCTAssertEqual(result, expectation)
    }

    func testBeginArray() {
        let json: String = """
        [
            {
                "a": 1,
                "b": 2
            },
            {
                "a": 1,
                "b": 2
            },
        ]
        """
        let expectation: String = """
        public struct Result: Codable {
            public let a: Int
            public let b: Int
        }
        """
        let result: String? = try? self.base.generate(json)
        XCTAssertEqual(result, expectation)
    }

    func testBeginArrayOptional() {
        let json: String = """
        [
            {
                "a": 1,
                "b": 2
            },
            {
                "a": 1,
                "c": 3
            },
        ]
        """
        let expectation: String = """
        public struct Result: Codable {
            public let a: Int
            public let b: Int?
            public let c: Int?
        }
        """
        let result: String? = try? self.base.generate(json)
        XCTAssertEqual(result, expectation)
    }

    func testBeginArrayWithCodingKeys() {
        let json: String = """
        [
            {
                "A": 1,
                "B": 2
            },
            {
                "A": 1,
                "B": 2
            },
        ]
        """
        let expectation: String = """
        public struct Result: Codable {
            public let a: Int
            public let b: Int

            private enum CodingKeys: String, CodingKey {
                case a = "A"
                case b = "B"
            }
        }
        """
        let result: String? = try? self.base.generate(json)
        XCTAssertEqual(result, expectation)
    }

    func testBeginArrayOptionalWithCodingKeys() {
        let json: String = """
        [
            {
                "A": 1,
                "B": 2
            },
            {
                "A": 1,
                "C": 3
            },
        ]
        """
        let expectation: String = """
        public struct Result: Codable {
            public let a: Int
            public let b: Int?
            public let c: Int?

            private enum CodingKeys: String, CodingKey {
                case a = "A"
                case b = "B"
                case c = "C"
            }
        }
        """
        let result: String? = try? self.base.generate(json)
        XCTAssertEqual(result, expectation)
    }

    func testArray() {
        let json: String = """
        {
            "array": [
                {
                    "a": 1
                },
                {
                    "a": 2
                },
            ]
        }
        """
        let expectation: String = """
        public struct Result: Codable {
            public let array: [Array]

            public struct Array: Codable {
                public let a: Int
            }
        }
        """
        let result: String? = try? self.base.generate(json)
        XCTAssertEqual(result, expectation)
    }

    func testArrayOptional() {
        let json: String = """
        {
            "array": [
                {
                    "a": 1,
                    "b": 2
                },
                {
                    "a": 1,
                    "c": 3
                },
            ]
        }
        """
        let expectation: String = """
        public struct Result: Codable {
            public let array: [Array]

            public struct Array: Codable {
                public let a: Int
                public let b: Int?
                public let c: Int?
            }
        }
        """
        let result: String? = try? self.base.generate(json)
        XCTAssertEqual(result, expectation)
    }

    func testArrayWithArrayCodingKeys() {
        let json: String = """
        {
            "Array": [
                {
                    "a": 1
                },
                {
                    "a": 1
                },
            ]
        }
        """
        let expectation: String = """
        public struct Result: Codable {
            public let array: [Array]

            public struct Array: Codable {
                public let a: Int
            }

            private enum CodingKeys: String, CodingKey {
                case array = "Array"
            }
        }
        """
        let result: String? = try? self.base.generate(json)
        XCTAssertEqual(result, expectation)
    }

    func testArrayOptionalWithArrayCodingKeys() {
        let json: String = """
        {
            "Array": [
                {
                    "a": 1,
                    "b": 2
                },
                {
                    "a": 1,
                    "c": 3
                },
            ]
        }
        """
        let expectation: String = """
        public struct Result: Codable {
            public let array: [Array]

            public struct Array: Codable {
                public let a: Int
                public let b: Int?
                public let c: Int?
            }

            private enum CodingKeys: String, CodingKey {
                case array = "Array"
            }
        }
        """
        let result: String? = try? self.base.generate(json)
        XCTAssertEqual(result, expectation)
    }

    func testArrayWithCodingKeys() {
        let json: String = """
        {
            "array": [
                {
                    "A": 1
                },
                {
                    "A": 1
                },
            ]
        }
        """
        let expectation: String = """
        public struct Result: Codable {
            public let array: [Array]

            public struct Array: Codable {
                public let a: Int

                private enum CodingKeys: String, CodingKey {
                    case a = "A"
                }
            }
        }
        """
        let result: String? = try? self.base.generate(json)
        XCTAssertEqual(result, expectation)
    }

    func testArrayOptionalWithCodingKeys() {
        let json: String = """
        {
            "array": [
                {
                    "A": 1,
                    "B": 2
                },
                {
                    "A": 1,
                    "C": 3
                },
            ]
        }
        """
        let expectation: String = """
        public struct Result: Codable {
            public let array: [Array]

            public struct Array: Codable {
                public let a: Int
                public let b: Int?
                public let c: Int?

                private enum CodingKeys: String, CodingKey {
                    case a = "A"
                    case b = "B"
                    case c = "C"
                }
            }
        }
        """
        let result: String? = try? self.base.generate(json)
        XCTAssertEqual(result, expectation)
    }

    func testArrayOptionalWithAllCodingKeys() {
        let json: String = """
        {
            "Array": [
                {
                    "A": 1,
                    "B": 2
                },
                {
                    "A": 1,
                    "C": 3
                },
            ]
        }
        """
        let expectation: String = """
        public struct Result: Codable {
            public let array: [Array]

            public struct Array: Codable {
                public let a: Int
                public let b: Int?
                public let c: Int?

                private enum CodingKeys: String, CodingKey {
                    case a = "A"
                    case b = "B"
                    case c = "C"
                }
            }

            private enum CodingKeys: String, CodingKey {
                case array = "Array"
            }
        }
        """
        let result: String? = try? self.base.generate(json)
        XCTAssertEqual(result, expectation)
    }

    func testArrayOptionalArrayWithAllCodingKeys() {
        let json: String = """
        {
            "Array": [
                {
                    "A": 1,
                    "B": [2]
                },
                {
                    "A": 1,
                    "C": [3]
                },
            ]
        }
        """
        let expectation: String = """
        public struct Result: Codable {
            public let array: [Array]

            public struct Array: Codable {
                public let a: Int
                public let b: [Int]?
                public let c: [Int]?

                private enum CodingKeys: String, CodingKey {
                    case a = "A"
                    case b = "B"
                    case c = "C"
                }
            }

            private enum CodingKeys: String, CodingKey {
                case array = "Array"
            }
        }
        """
        let result: String? = try? self.base.generate(json)
        XCTAssertEqual(result, expectation)
    }

    func testMultArrayWithAllCodingKeys() {
        let json: String = """
        [
            {
                "test": "test"
                "Array": [
                    {
                        "A": 1,
                        "B": 2
                    },
                    {
                        "A": 1,
                        "C": 3
                    },
                ]
            },
            {
                "Array": [
                    {
                        "A": 1,
                        "B": 2
                    },
                    {
                        "A": 1,
                        "C": 3
                    },
                ]
            }
        ]
        """
        let expectation: String = """
        public struct Result: Codable {
            public let test: String?
            public let array: [Array]

            public struct Array: Codable {
                public let a: Int
                public let b: Int?
                public let c: Int?

                private enum CodingKeys: String, CodingKey {
                    case a = "A"
                    case b = "B"
                    case c = "C"
                }
            }

            private enum CodingKeys: String, CodingKey {
                case test
                case array = "Array"
            }
        }
        """
        let result: String? = try? self.base.generate(json)
        XCTAssertEqual(result, expectation)
    }

    func testArrayInObject() {
        let json: String = """
        {
            "Object": {
                "array": [
                    1,
                    2,
                    3
                ]
            }
        }
        """
        let expectation: String = """
        public struct Result: Codable {
            public let object: Object

            public struct Object: Codable {
                public let array: [Int]
            }

            private enum CodingKeys: String, CodingKey {
                case object = "Object"
            }
        }
        """
        let result: String? = try? self.base.generate(json)
        XCTAssertEqual(result, expectation)
    }

    func testArrayObject() {
        let json: String = """
        {
            "array": [
                {
                    "number": 1,
                    "InArray-Object": {
                        "hello": "world"
                    }
                },
                {
                    "number": 1,
                    "InArray-Object": {
                        "hello": "world"
                    }
                }
            ]
        }
        """
        let expectation: String = """
        public struct Result: Codable {
            public let array: [Array]

            public struct Array: Codable {
                public let number: Int
                public let inArrayObject: InArrayObject

                public struct InArrayObject: Codable {
                    public let hello: String
                }

                private enum CodingKeys: String, CodingKey {
                    case number
                    case inArrayObject = "InArray-Object"
                }
            }
        }
        """
        let result: String? = try? self.base.generate(json)
        XCTAssertEqual(result, expectation)
    }

    func testNestedArrayObjectInObject() {
        let json: String = """
        {
            "Object": {
                "array": [
                    {
                        "InArray-Object": {
                            "hello": "world"
                        },
                        "number": 1
                    },
                    {
                        "InArray-Object": {
                            "hello": "world"
                        },
                        "number": 1
                    }
                ]
            }
        }
        """
        let expectation: String = """
        public struct Result: Codable {
            public let object: Object

            public struct Object: Codable {
                public let array: [Array]

                public struct Array: Codable {
                    public let inArrayObject: InArrayObject
                    public let number: Int

                    public struct InArrayObject: Codable {
                        public let hello: String
                    }

                    private enum CodingKeys: String, CodingKey {
                        case inArrayObject = "InArray-Object"
                        case number
                    }
                }
            }

            private enum CodingKeys: String, CodingKey {
                case object = "Object"
            }
        }
        """
        let result: String? = try? self.base.generate(json)
        XCTAssertEqual(result, expectation)
    }

    func testArrayObjectWithOptionals() {
        let json: String = """
        {
            "array": [
                {
                    "InArray-Object:WithOptionals": {
                        "hello": "world"
                    }
                },
                {
                    "InArray-Object:WithOptionals": {
                        "hello": "world",
                        "number": 1
                    }
                }
            ]
        }
        """
        let expectation: String = """
        public struct Result: Codable {
            public let array: [Array]

            public struct Array: Codable {
                public let inArrayObjectWithOptionals: InArrayObjectWithOptionals

                public struct InArrayObjectWithOptionals: Codable {
                    public let hello: String
                    public let number: Int?
                }

                private enum CodingKeys: String, CodingKey {
                    case inArrayObjectWithOptionals = "InArray-Object:WithOptionals"
                }
            }
        }
        """
        let result: String? = try? self.base.generate(json)
        XCTAssertEqual(result, expectation)
    }

    func testMultArrayObjectWithOptionals() {
        let json: String = """
        {
            "array": [
                {
                    "Obj:First": {
                        "hello": "world"
                    }
                },
                {
                    "Obj:First": {
                        "hello": "world"
                    },
                    "Obj:Second": {
                        "hello": "world"
                    }
                }
            ]
        }
        """
        let expectation: String = """
        public struct Result: Codable {
            public let array: [Array]

            public struct Array: Codable {
                public let objFirst: ObjFirst
                public let objSecond: ObjSecond?

                public struct ObjFirst: Codable {
                    public let hello: String
                }

                public struct ObjSecond: Codable {
                    public let hello: String
                }

                private enum CodingKeys: String, CodingKey {
                    case objFirst = "Obj:First"
                    case objSecond = "Obj:Second"
                }
            }
        }
        """
        let result: String? = try? self.base.generate(json)
        XCTAssertEqual(result, expectation)
    }

    func testArrayObjectWithOptionalsWithAllCodingKeys() {
        let json: String = """
        {
            "array": [
                {
                    "InArray-Object:WithOptionals": {
                        "hello": "world"
                    }
                },
                {
                    "InArray-Object:WithOptionals": {
                        "hello": "world",
                        "Number": 1
                    }
                }
            ]
        }
        """
        let expectation: String = """
        public struct Result: Codable {
            public let array: [Array]

            public struct Array: Codable {
                public let inArrayObjectWithOptionals: InArrayObjectWithOptionals

                public struct InArrayObjectWithOptionals: Codable {
                    public let hello: String
                    public let number: Int?

                    private enum CodingKeys: String, CodingKey {
                        case hello
                        case number = "Number"
                    }
                }

                private enum CodingKeys: String, CodingKey {
                    case inArrayObjectWithOptionals = "InArray-Object:WithOptionals"
                }
            }
        }
        """
        let result: String? = try? self.base.generate(json)
        XCTAssertEqual(result, expectation)
    }

    func testNestedArrayOptionalObjectInObject() {
        let json: String = """
        {
            "Object": {
                "array": [
                    {
                        "number": 1,
                        "Optional-Object": {
                            "hello": "world"
                        }
                    },
                    {
                        "number": 1
                    }
                ]
            }
        }
        """
        let expectation: String = """
        public struct Result: Codable {
            public let object: Object

            public struct Object: Codable {
                public let array: [Array]

                public struct Array: Codable {
                    public let number: Int
                    public let optionalObject: OptionalObject?

                    public struct OptionalObject: Codable {
                        public let hello: String
                    }

                    private enum CodingKeys: String, CodingKey {
                        case number
                        case optionalObject = "Optional-Object"
                    }
                }
            }

            private enum CodingKeys: String, CodingKey {
                case object = "Object"
            }
        }
        """
        let result: String? = try? self.base.generate(json)
        XCTAssertEqual(result, expectation)
    }
}
