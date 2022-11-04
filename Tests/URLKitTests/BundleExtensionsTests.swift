//
//  BundleExtensionsTests.swift
//  URLKit
//
//  Created by yukonblue on 07/29/2022.
//

import CoreFoundation

import XCTest
@testable import URLKit

class BundleExtensionsTests: XCTestCase {

    func testBundleMainIdentifier() throws {
        #if false
        let mainBundle = CFBundleGetMainBundle()
        let mainIdentifier = try XCTUnwrap(CFBundleGetIdentifier(mainBundle))

        XCTAssertEqual(Bundle.main.mainIdentifier, ((mainIdentifier as NSString) as String))
        #else
        XCTAssertEqual(Bundle.main.mainIdentifier, "URLKitTests")
        #endif
    }
}
