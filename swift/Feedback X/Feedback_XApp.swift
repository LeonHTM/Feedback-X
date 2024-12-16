//
//  Feedback_XApp.swift
//  Feedback X
//
//  Created by Leon  on 10.12.2024
//
import SwiftUI

@main
struct Feedback_XApp: App {
    @AppStorage("AppLaunchCounter") public var AppLaunchCounter: Int = 0
    
    init() {
        print("App has launched \(AppLaunchCounter) times")
        
    }
    
    var body: some Scene {
        Window("",id:"FeedbackXMain") {
            SidebarView()
            
        }
        Settings{
            SettingsView()
        }
    }
}




