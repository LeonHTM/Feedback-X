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
    @AppStorage("CreateshowSheet1") var CreateshowSheet1: Bool = false
    @AppStorage("CreateshowSheet2") var CreateshowSheet2: Bool = false
    @AppStorage("AccountshowSheet1") var AccountshowSheet1: Bool = false
    @AppStorage("AccountshowSheet2") var AccountshowSheet2: Bool = false
    @AppStorage("topicshowSheet1") var topicShowSheet1:Bool = false
    @AppStorage("topicshowSheet2") var topicShowSheet2:Bool = false
    @AppStorage("CookiesshowSheet") var CookiesshowSheet: Bool = false
    
    @StateObject private var accountLoader = AccountLoader()
    @StateObject private var feedbackPython = FeedbackPython(scriptPath:"/Users/leon/Desktop/Feedback-X/python/code/main.py")
    @StateObject private var cookiesPython = CookiesPython(scriptPath: "/Users/leon/Desktop/Feedback-X/python/code/main_cookies.py")
    @StateObject private var fileLoader = FileLoader(folderURL: URL(fileURLWithPath: "/Users/leon/Desktop/Feedback-X/python/saves"))
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
                .environmentObject(cookiesPython)
                .environmentObject(fileLoader)
                .onAppear {
                    //NSWindow.allowsAutomaticWindowTabbing = false
                    CreateshowSheet2 = false
                    CreateshowSheet1 = false
                    AccountshowSheet1 = false
                    CookiesshowSheet = false
                    AccountshowSheet2 = false
                    topicShowSheet1 = false
                    topicShowSheet2 = false
                    
                  
                    
                }
                .onDisappear{
                    
                    CreateshowSheet2 = false
                    CreateshowSheet1 = false
                    AccountshowSheet1 = false
                    CookiesshowSheet = false
                    AccountshowSheet2 = false
                    topicShowSheet1 = false
                    topicShowSheet2 = false
                }
                
        }/*.commands {
            CommandGroup(replacing: .newItem, addition: { })
        }*/
        Settings {
            SettingsView()
                .environmentObject(accountLoader)
                .environmentObject(fileLoader)
                
        }
    }
}



