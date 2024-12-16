//
//  Feedback_XApp.swift
//  Feedback X
//
//  Created by Leon  on 10.12.2024
//
import SwiftUI

@main
struct Feedback_XApp: App {
    var body: some Scene {
        Window("",id:"FeedbackXMain") {
            HStack() {
                SidebarView()
                Spacer()
            }
            .frame(minWidth: 700, idealWidth: 925, minHeight: 400, idealHeight: 625)
        }
        Settings{
            SettingsView()
        }
    }
}



