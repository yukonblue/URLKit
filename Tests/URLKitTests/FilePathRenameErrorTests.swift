//
//  FilePathRenameErrorTests.swift
//  URLKit
//
//  Created by yukonblue on 07/29/2022.
//

import Foundation

import XCTest
@testable import URLKit

class FilePathRenameErrorTests: XCTestCase {

    func testError() throws {
        let sourceURL = URL(fileURLWithPath: "/tmp/tmp-file.tmp")
        let destURL = URL(fileURLWithPath: "/Downloads/")
        let replacementExt = "data"

        let filePathRenameError: URL.FilePathRenameError = .init(sourceURL: sourceURL, destURL: destURL, replacementExt: replacementExt)

        let nsError: NSError = filePathRenameError as NSError

        let expectedDescription = "(extension in URLKit):Foundation.URL.FilePathRenameError(sourceURL: file:///tmp/tmp-file.tmp, destURL: file:///Downloads/, replacementExt: \"data\")"

        XCTAssertEqual(nsError.description, expectedDescription)
        XCTAssertEqual(nsError.debugDescription, expectedDescription)
        XCTAssertEqual(nsError.code, 1)
        XCTAssertEqual(nsError.domain, "(extension in URLKit):Foundation.URL.FilePathRenameError")
    }
}
