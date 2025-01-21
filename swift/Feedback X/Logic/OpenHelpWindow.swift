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
    
    // Static variable to track if the Help window has been opened
    private static var hasLaunched: Bool = false
    
    static func open() {
        // Check if the window has already been opened
        if hasLaunched {
            print("Help window is already open.")
            return
        }
        
        // Create the Help window
        let helpWindow = NSWindow(
            contentViewController: NSHostingController(rootView: HelpView())
        )

        helpWindow.title = "Feedback X User Guide"
        helpWindow.styleMask = [.resizable, .titled, .closable, .miniaturizable, .fullSizeContentView]
        helpWindow.titlebarAppearsTransparent = true
        helpWindow.titleVisibility = .hidden
        

        
        
       
        
        
        // Position window in the center of the primary screen
        if let screen = NSScreen.main {
            let screenFrame = screen.frame
            let windowWidth: CGFloat = 1100
            let windowHeight: CGFloat = 750
            
            // Calculate the center point
            let xPosition = (screenFrame.width - windowWidth) / 2
            let yPosition = (screenFrame.height - windowHeight) / 2
            
            // Set the window's frame to the calculated position
            helpWindow.setFrame(CGRect(x: xPosition, y: yPosition, width: windowWidth, height: windowHeight), display: true)
        }
        
        // Show the window
        helpWindow.makeKeyAndOrderFront(nil)
        
        // Mark the window as launched
        hasLaunched = true
    }
    
    // Function to reset the launch status, allowing the window to be opened again
    static func resetLaunchStatus() {
        hasLaunched = false
    }
}


