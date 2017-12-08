//
//  AppDelegate.swift
//  TwistSearchClient
//
//  Created by Ivan Blagajić on 06/12/2017.
//  Copyright © 2017 Five Dollar Milkshake. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var navigationService: NavigationService?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.navigationService = NavigationService()
        NSApp.mainMenu = NSMenu()
        NSApp.activate(ignoringOtherApps: true)
    }

}

