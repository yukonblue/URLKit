//
//  AppContainerDirectoryTests.swift
//  URLKit
//
//  Created by yukonblue on 07/29/2022.
//

import Foundation

import XCTest
@testable import URLKit

class AppContainerDirectoryTests: XCTestCase {

    func testCacheDirectory() throws {
        let cacheDirectory = try XCTUnwrap(CacheDirectory(name: "Assets"))

        try self._testURLs(for: cacheDirectory)
        try self._testMoveItem(for: cacheDirectory)
    }

    func testDocumentDirectory() throws {
        let documentDirectory = try XCTUnwrap(DocumentDirectory(name: "Assets"))

        try self._testURLs(for: documentDirectory)
        try self._testMoveItem(for: documentDirectory)
    }

    func _testURLs<Category>(for appContainerDirectory: AppContainerDirectory<Category>) throws {
        XCTAssertTrue(appContainerDirectory.baseURL.isFileURL)
        XCTAssertTrue(appContainerDirectory.url.isFileURL)

        var isBaseUrlDir : ObjCBool = false
        XCTAssertTrue(FileManager.default.fileExists(atPath: appContainerDirectory.baseURL.path, isDirectory: &isBaseUrlDir))
        XCTAssertTrue(isBaseUrlDir.boolValue)

        var isUrlDir : ObjCBool = false
        XCTAssertTrue(FileManager.default.fileExists(atPath: appContainerDirectory.url.path, isDirectory: &isUrlDir))
        XCTAssertTrue(isUrlDir.boolValue)
    }

    func _testMoveItem<Category>(for appContainerDirectory: AppContainerDirectory<Category>) throws {
        let originalFilename = "\(UUID().uuidString).tmp"

        var tempFileURL = NSURL.fileURL(withPath: NSTemporaryDirectory(), isDirectory: true)
        tempFileURL.appendPathComponent(originalFilename)

        XCTAssertTrue(tempFileURL.isFileURL)

        let sourceData = "Hello, World!".data(using: .utf8)!

        try sourceData.write(to: tempFileURL)

        var isTempFileUrlDir : ObjCBool = false
        XCTAssertTrue(FileManager.default.fileExists(atPath: tempFileURL.path, isDirectory: &isTempFileUrlDir))
        XCTAssertFalse(isTempFileUrlDir.boolValue)

        let newFileExt = "data"

        let (destURL, newFilename) = try appContainerDirectory.moveItem(from: tempFileURL, replaceWithFileExtension: newFileExt)

        // Check that the destination URL exists and is a file (not a directory).
        XCTAssertTrue(destURL.isFileURL)

        var isUrlDir : ObjCBool = false
        XCTAssertTrue(FileManager.default.fileExists(atPath: destURL.path, isDirectory: &isUrlDir))
        XCTAssertFalse(isUrlDir.boolValue)

        // Check the new file name contains the new extension, and is different from the original file name.
        XCTAssertNotEqual(newFilename, originalFilename)
        XCTAssertEqual(try XCTUnwrap(URL(string: newFilename)?.pathExtension), newFileExt)

        // Last, check the file content matches.
        let destData = try XCTUnwrap(Data(contentsOf: destURL))

        XCTAssertEqual(destData, sourceData)
    }
}
