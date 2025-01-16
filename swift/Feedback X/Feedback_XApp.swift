//
//  Feedback_XApp.swift
//  Feedback X
//
//  Created by Leon  on 10.12.2024
//
import SwiftUI

@main
struct Feedback_XApp: App {
    @AppStorage("AppLaunchCounter") var appLaunchCounter: Int = 0
    @StateObject private var accountLoader = AccountLoader()
    @StateObject private var feedbackPython = FeedbackPython(scriptPath:"/Users/leon/Desktop/Feedback-X/python/code/main.py")
    
    var fullDelete: Bool = true


    init() {
        appLaunchCounter += 1
        print("App has launched \(appLaunchCounter) times")
        
    }
    
    var body: some Scene {
        Window("", id: "FeedbackXMain") {
            SidebarView()
                .environmentObject(accountLoader)
                .environmentObject(feedbackPython)
                
        }
        Settings {
            SettingsView()
                .environmentObject(accountLoader)
                
        }
    }
}



