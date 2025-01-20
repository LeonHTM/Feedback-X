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
            return
        }
        
        // Create the Help window
        let helpWindow = NSWindow(
            contentViewController: NSHostingController(rootView: HelpView().frame(minWidth: 1100, minHeight: 750))
        )
        helpWindow.title = "Feedback X User Guide"
        helpWindow.makeKeyAndOrderFront(nil)
        helpWindow.isReleasedWhenClosed = false // Keeps window open until closed manually
        
        // Mark the window as launched
        hasLaunched = true
    }
    
    // Function to reset the launch status, allowing the window to be opened again
    static func resetLaunchStatus() {
        hasLaunched = false
    }
}
