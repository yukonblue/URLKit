//
//  String+PathComponent.swift
//  URLKit
//
//  Created by yukonblue on 07/22/2022.
//

import Foundation

extension String {

    public func appending(pathComponent: String) -> String {
        (self as NSString).appendingPathComponent(pathComponent)
    }
}
