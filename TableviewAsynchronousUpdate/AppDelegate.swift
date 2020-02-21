//
//  AppDelegate.swift
//  TableviewAsynchronousUpdate
//
//  Created by Bharatraj Rai on 2/16/20.
//  Copyright © 2020 Bharatraj Rai. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    
    // MainViewController is the class that will parse the data from json file and load the content in tableview
    var mainVC: MainViewController?


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        openMainView()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func openMainView() {
        mainVC = MainViewController(nibName: "MainViewController", bundle: nil)
        window.setContentSize(mainVC?.view.fittingSize ?? NSSize(width: 350, height: 540))
        window.contentViewController = mainVC
    }


}

