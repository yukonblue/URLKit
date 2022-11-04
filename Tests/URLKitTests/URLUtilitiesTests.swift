//
//  URLUtilitiesTests.swift
//  URLKit
//
//  Created by yukonblue on 07/22/2022.
//

import Foundation

import XCTest
@testable import URLKit

class URLUtilitiesTests: XCTestCase {

    func testNewFilenameWithNewExtension() throws {
        let url = URL(fileURLWithPath: "/var/mobile/Containers/Data/Application/70408EF0-B05A-481B-B9E5-66EF384A7B86/Library/Caches/com.yukonblue.Heartship/Assets/TmpDownload.tmp")

        let newFilename = try XCTUnwrap(url.newFilename(replaceFileExtension: "mp3", replaceFilename: nil))

        XCTAssertEqual(newFilename, "TmpDownload.mp3")
    }

    func testNewFilenameWithNewFilenameAndExtension() throws {
        let url = URL(fileURLWithPath: "/var/mobile/Containers/Data/Application/70408EF0-B05A-481B-B9E5-66EF384A7B86/Library/Caches/com.yukonblue.Heartship/Assets/TmpDownload.tmp")

        let newFilename = try XCTUnwrap(url.newFilename(replaceFileExtension: "mp4", replaceFilename: "MyAwesomeNewFileName"))

        XCTAssertEqual(newFilename, "MyAwesomeNewFileName.mp4")
    }

    func testNewFilenameWithDirectoryName() throws {
        let url = URL(fileURLWithPath: "/var/mobile/Containers/Data/Application/70408EF0-B05A-481B-B9E5-66EF384A7B86/")

        let newFilename = try XCTUnwrap(url.newFilename(replaceFileExtension: "mp4", replaceFilename: "MyAwesomeNewFileName"))

        XCTAssertEqual(newFilename, "MyAwesomeNewFileName.mp4")
    }

    func testNewFilenameWithNonFileURL() throws {
        let url = URL(string: "https://apple.com")!

        let newFilename = url.newFilename(replaceFileExtension: "mp4", replaceFilename: "MyAwesomeNewFileName")

        XCTAssertNil(newFilename)
    }
}
