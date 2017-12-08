//
//  NSWindow+Twist.swift
//  TwistSearchClient
//
//  Created by Ivan Blagajić on 08/12/2017.
//  Copyright © 2017 Five Dollar Milkshake. All rights reserved.
//

import AppKit

extension NSWindow {

    static var standard: NSWindow {
        let window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 600, height: 400),
                              styleMask: [.titled, .fullSizeContentView],
                              backing: .buffered,
                              defer: false)
        window.isMovableByWindowBackground = true
        window.titleVisibility = .hidden
        window.titlebarAppearsTransparent = true
        window.center()
        window.title = "Twist"
        window.orderFrontRegardless()
        return window
    }
    
}
