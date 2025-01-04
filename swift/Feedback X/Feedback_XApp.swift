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
    var fullDelete: Bool = true


    init() {
        appLaunchCounter += 1
        print("App has launched \(appLaunchCounter) times")
        
    }
    
    var body: some Scene {
        Window("", id: "FeedbackXMain") {
            SidebarView()
                .environmentObject(accountLoader)
                
        }
        Settings {
            SettingsView()
                .environmentObject(accountLoader)
                
        }
    }
}



