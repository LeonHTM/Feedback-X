//
//  OpenHelpWindow.swift
//  Feedback X
//
//  Created by Leon  on 20.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import Foundation
import SwiftUI

public struct OpenHelpWindow {
    
    private static var hasLaunched: Bool = false
    private static var helpWindow: NSWindow?

    static func open() {
        if let window = helpWindow {
            window.makeKeyAndOrderFront(nil)
            return
        }
        
        let newWindow = NSWindow(
            contentViewController: NSHostingController(rootView: HelpView())
        )
        
        newWindow.title = "Feedback X User Guide"
        newWindow.styleMask = [.resizable, .titled, .closable, .miniaturizable, .fullSizeContentView]
        newWindow.titlebarAppearsTransparent = true
        newWindow.titleVisibility = .hidden
        
       
        if let screen = NSScreen.main {
            let screenFrame = screen.frame
            let windowWidth: CGFloat = 1100
            let windowHeight: CGFloat = 750
            
            let xPosition = (screenFrame.width - windowWidth) / 2
            let yPosition = (screenFrame.height - windowHeight) / 2
            
            newWindow.setFrame(CGRect(x: xPosition, y: yPosition, width: windowWidth, height: windowHeight), display: true)
        }
        
        helpWindow = newWindow  // Fenster speichern
        newWindow.makeKeyAndOrderFront(nil)
        
        hasLaunched = true
    }
    
   
    static func resetLaunchStatus() {
        hasLaunched = false
        helpWindow?.close()
        helpWindow = nil
    }
    
    static func back() {
        
        helpWindow?.orderBack(nil)
        NSApp.windows.first?.makeKeyAndOrderFront(nil)
    }
}
