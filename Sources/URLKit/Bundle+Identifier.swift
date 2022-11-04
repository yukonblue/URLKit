//
//  Bundle+Identifier.swift
//  URLKit
//
//  Created by yukonblue on 07/22/2022.
//

import Foundation

extension Bundle {

    public var mainIdentifier: String {
        class __ {}
        return Bundle(for: __.self).bundleIdentifier ?? "com.yukonblue.Heartship"
    }
}
