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
    @AppStorage("CreateshowSheet") var CreateshowSheet: Bool = false
    @AppStorage("AccountshowSheet") var AccountshowSheet: Bool = false
    @AppStorage("AccountshowSheet2") var AccountshowSheet2: Bool = false
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
                    CreateshowSheet = false
                    AccountshowSheet = false
                    CookiesshowSheet = false
                    AccountshowSheet2 = false
                    
                  
                    
                }
                .onDisappear{
                    
                    CreateshowSheet = false
                    AccountshowSheet = false
                    CookiesshowSheet = false
                    AccountshowSheet2 = false
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



