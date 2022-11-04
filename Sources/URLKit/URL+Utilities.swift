//
//  URL+Utilities.swift
//  URLKit
//
//  Created by yukonblue on 07/22/2022.
//

import Foundation

extension URL {

    public struct FilePathRenameError: Error {

        let sourceURL: URL
        let destURL: URL
        let replacementExt: String

        var description: String {
            (self as NSError).description
        }
    }

    public func newFilename(replaceFileExtension newExt: String,
                            replaceFilename newFilename: String? = nil
    ) -> String? {
        guard self.isFileURL else {
            return nil
        }
        let currentFilenameWithoutExtension = self.deletingPathExtension().lastPathComponent
        let filenameWithoutExtension = newFilename ?? currentFilenameWithoutExtension
        return (filenameWithoutExtension as NSString).appendingPathExtension(newExt)
    }
}
