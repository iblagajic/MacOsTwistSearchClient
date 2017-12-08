//
//  NSFont+Twist.swift
//  TwistSearchClient
//
//  Created by Ivan Blagajić on 08/12/2017.
//  Copyright © 2017 Five Dollar Milkshake. All rights reserved.
//

import AppKit

extension NSFont {

    static func body() -> NSFont {
        return NSFont.systemFont(ofSize: 14)
    }

    static func header() -> NSFont {
        return NSFont.systemFont(ofSize: 16, weight: .medium)
    }

    static func title() -> NSFont {
        return NSFont.systemFont(ofSize: 14, weight: .medium)
    }

    static func subtitle() -> NSFont {
        return NSFont.systemFont(ofSize: 13)
    }

}
