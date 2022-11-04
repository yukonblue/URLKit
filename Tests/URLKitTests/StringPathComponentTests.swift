//
//  StringPathComponentTests.swift
//  URLKit
//
//  Created by yukonblue on 08/31/2022.
//

import Foundation

import XCTest
@testable import URLKit

class StringPathComponentTests: XCTestCase {

    func testAppendPathComponent() throws {
        let path = "/Users/me/Desktop"
        let component = "MyFile.ext"
        let expected = "/Users/me/Desktop/MyFile.ext"

        try self._testAppendPathComponent(withPath: path, component: component, expected: expected)
    }

    func testAppendPathComponentOnPathWithForwardSlash() throws {
        let path = "/Users/me/Desktop/"
        let component = "MyFile.ext"
        let expected = "/Users/me/Desktop/MyFile.ext"

        try self._testAppendPathComponent(withPath: path, component: component, expected: expected)
    }

    func testAppendPathComponentOnRootPath() throws {
        let path = "/"
        let component = "MyFile.ext"
        let expected = "/MyFile.ext"

        try self._testAppendPathComponent(withPath: path, component: component, expected: expected)
    }

    func _testAppendPathComponent(withPath path: String, component: String, expected: String) throws {
        let result = path.appending(pathComponent: component)
        XCTAssertEqual(result, expected)
    }
}
