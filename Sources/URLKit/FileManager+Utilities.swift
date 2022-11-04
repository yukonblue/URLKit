//
//  FileManager+Utilities.swift
//  URLKit
//
//  Created by yukonblue on 07/22/2022.
//

import Foundation

extension FileManager {

    /// Moves a file from a source URL to under a destination directory URL,
    /// with the option of replacing the existing file name as well as extension.
    ///
    /// - Parameters:
    ///   - sourceURL: The URL of the source file to be copied under.
    ///   - destURL: The URL of the destination directory to be copied over.
    ///   - newExt: The new file extension to be replaced with once the file is copied over.
    ///   - usesUniqueFilename: A boolean indicating whether to replace the file's name with a newly created unique name once it's copied over.
    /// - Returns: A pair that consists of the absolute URL of the copied over path, as well as the new file name with extension.
    /// - Throws: An error if the operation fails.
    public func moveItem(from sourceURL: URL,
                         to destURL: URL,
                         replaceWithFileExtension newExt: String,
                         usesUniqueFilename: Bool = false
    ) throws -> (url: URL, newFilename: String)  {
        if let newFilename = sourceURL.newFilename(replaceFileExtension: newExt, replaceFilename: usesUniqueFilename ? UUID().uuidString : nil) {
            let destinationURL = URL(fileURLWithPath: destURL.path.appending(pathComponent: newFilename))
            try self.moveItem(at: sourceURL, to: destinationURL)
            return (url: destinationURL, newFilename: newFilename)
        } else {
            throw URL.FilePathRenameError(sourceURL: sourceURL, destURL: destURL, replacementExt: newExt)
        }
    }
}
