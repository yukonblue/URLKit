//
//  AppContainerDirectory.swift
//  URLKit
//
//  Created by yukonblue on 07/22/2022.
//

import Foundation
import os

public protocol AppContainerDirectoryCategory {

    static var searchPathDirectory: FileManager.SearchPathDirectory { get }
}

public class AppContainerDirectory<DirectoryCategory: AppContainerDirectoryCategory> {

    let baseURL: URL
    let url: URL

    public init?(name subdirName: String? = nil) {
        if let sysCacheDirURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first {
            self.baseURL = URL(fileURLWithPath: sysCacheDirURL.path.appending(pathComponent: Bundle.main.mainIdentifier))

            if let subdirName = subdirName {
                self.url = URL(fileURLWithPath: self.baseURL.path.appending(pathComponent: subdirName))
            } else {
                self.url = self.baseURL
            }

            var isDir : ObjCBool = false
            if !FileManager.default.fileExists(atPath: self.url.path, isDirectory: &isDir) {
                do {
                    try FileManager.default.createDirectory(atPath: self.url.path, withIntermediateDirectories: true, attributes: [:])
                } catch {
                    let nsError = error as NSError
                    logger().error("Failed to create directory at \(self.url). Error: \(nsError)")
                    return nil
                }
            } else if !isDir.boolValue {
                // A file with the same name already exists
                logger().error("Attempted to create directory at path \(self.url) but there exists a conflicting file at the same location.")
                return nil
            }
        } else {
            logger().error("Failed to locate a suitable location with `FileManager.SearchPathDirectory` enum value \(DirectoryCategory.searchPathDirectory.rawValue)")
            return nil
        }
    }

    public func moveItem(from sourceURL: URL, replaceWithFileExtension newExt: String) throws -> (url: URL, newFilename: String) {
        try FileManager.default.moveItem(from: sourceURL, to: self.url, replaceWithFileExtension: newExt, usesUniqueFilename: true)
    }
}

public struct CacheDirectoryCategory: AppContainerDirectoryCategory {

    public static let searchPathDirectory: FileManager.SearchPathDirectory = .cachesDirectory
}

public struct DocumentDirectoryCategory: AppContainerDirectoryCategory {

    public static let searchPathDirectory: FileManager.SearchPathDirectory = .documentDirectory
}

public typealias CacheDirectory = AppContainerDirectory<CacheDirectoryCategory>

public typealias DocumentDirectory = AppContainerDirectory<DocumentDirectoryCategory>

public enum AppContainer {

    /// The local assets directory used for storing downloaded files (i.e. media files, images, etc).
    ///
    /// **NOTE:**
    /// Frozen. Cannot change in future.
    public static let assetsDirectory = DocumentDirectory(name: "Assets")
}

fileprivate func logger() -> Logger {
    Logger(subsystem: Bundle.main.mainIdentifier, category: "file")
}
