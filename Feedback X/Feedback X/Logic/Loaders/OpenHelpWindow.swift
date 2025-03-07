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
    
    // Indicates if the help window has been launched
    private static var hasLaunched: Bool = false
    // Reference to the help window
    private static var helpWindow: NSWindow?

    // Function to open the help window
    static func open() {
        // If the help window already exists, bring it to the front
        if let window = helpWindow {
            window.makeKeyAndOrderFront(nil)
            return
        }
        
        // Create a new help window
        let newWindow = NSWindow(
            contentViewController: NSHostingController(rootView: HelpView())
        )
        
        // Set window properties
        newWindow.title = "Feedback X User Guide"
        newWindow.styleMask = [.resizable, .titled, .closable, .miniaturizable, .fullSizeContentView]
        newWindow.titlebarAppearsTransparent = true
        newWindow.titleVisibility = .hidden
        
        // Center the window on the screen
        if let screen = NSScreen.main {
            let screenFrame = screen.frame
            let windowWidth: CGFloat = 1100
            let windowHeight: CGFloat = 750
            
            let xPosition = (screenFrame.width - windowWidth) / 2
            let yPosition = (screenFrame.height - windowHeight) / 2
            
            newWindow.setFrame(CGRect(x: xPosition, y: yPosition, width: windowWidth, height: windowHeight), display: true)
        }
        
        // Save the reference to the help window
        helpWindow = newWindow
        newWindow.makeKeyAndOrderFront(nil)
        
        // Mark the help window as launched
        hasLaunched = true
    }
    
    // Function to reset the launch status and close the help window
    static func resetLaunchStatus() {
        hasLaunched = false
        helpWindow?.close()
        helpWindow = nil
    }
    
    // Function to move the help window to the back
    static func back() {
        helpWindow?.orderBack(nil)
        NSApp.windows.first?.makeKeyAndOrderFront(nil)
    }
}
