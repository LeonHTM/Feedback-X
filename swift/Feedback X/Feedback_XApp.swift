//
//  Feedback_XApp.swift
//  Feedback X
//
//  Created by Leon  on 10.12.2024
//

import SwiftUI

@main
struct Feedback_XApp: App {
    // App launch counter stored in UserDefaults
    @AppStorage("AppLaunchCounter") var appLaunchCounter: Int = 0
    
    // Boolean values to control sheet presentations
    @AppStorage("CreateshowSheet1") var CreateshowSheet1: Bool = false
    @AppStorage("CreateshowSheet2") var CreateshowSheet2: Bool = false
    @AppStorage("CreateshowSheet3") var CreateshowSheet3: Bool = false
    @AppStorage("AccountshowSheet1") var AccountshowSheet1: Bool = false
    @AppStorage("AccountshowSheet2") var AccountshowSheet2: Bool = false
    @AppStorage("AccountshowSheet3") var AccountshowSheet3: Bool = false
    @AppStorage("topicshowSheet1") var topicShowSheet1: Bool = false
    @AppStorage("topicshowSheet2") var topicShowSheet2: Bool = false
    @AppStorage("topicshowSheet3") var topicShowSheet3: Bool = false
    @AppStorage("CookiesshowSheet") var CookiesshowSheet: Bool = false
    
    // Selected indices and sidebar page tracking
    @AppStorage("selectedIndex") var selectedIndex: Int?
    @AppStorage("selectedIndexActivity") var selectedIndexActivity: Int?
    @AppStorage("SideBarPage") var selectedPageSideBar: String = "Recent Activity"
    @AppStorage("aboutSelectedPage") var selectedPageAbout: String = "Privacy"
    
    // File paths for external resources
    @AppStorage("accountsPath") var accountsPath: String = "/Users/leon/Desktop/Feedback-X/python/accounts/accounts.json"
    var accountURL: URL {
        URL(fileURLWithPath: accountsPath)
    }
    
    @AppStorage("savesPath") var savesPath: String = "/Users/leon/Desktop/Feedback-X/python/saves"
    var savesURL: URL {
            URL(fileURLWithPath: savesPath)
        }
    
    @AppStorage("mainPath") var mainPath: String = "/Users/leon/Desktop/Feedback-X/python/code/main.py"
    @AppStorage("cookiesPath") var cookiesPath: String = "/Users/leon/Desktop/Feedback-X/python/code/main_cookies.py"
    
    
    // State variables for UI control
    @State private var showAccountAlert: Bool = false
    @State private var topicSave: String = "iOS & iPadOS"
    
    // State objects for managing data and scripts
    @StateObject private var accountLoader = AccountLoader()
    @StateObject private var feedbackPython: FeedbackPython
    @StateObject private var cookiesPython: CookiesPython
    @StateObject private var fileLoader: FileLoader
    
    var fullDelete: Bool = true
    
    // Function to reset various UI states
    func reset() {
        CreateshowSheet1 = false
        CreateshowSheet2 = false
        CreateshowSheet3 = false
        AccountshowSheet1 = false
        AccountshowSheet2 = false
        AccountshowSheet3 = false
        CookiesshowSheet = false
        topicShowSheet1 = false
        topicShowSheet2 = false
        topicShowSheet3 = false
        selectedIndex = -1
        selectedIndexActivity = -1
        selectedPageSideBar = "Recent Activity"
        selectedPageAbout = "Privacy"
    }
    
    // App initialization
    init() {
        
        //Load App Storage into State Objects 
        _fileLoader = StateObject(wrappedValue: FileLoader(folderURL: URL(fileURLWithPath: UserDefaults.standard.string(forKey: "savesPath") ?? "/Users/leon/Desktop/Feedback-X/python/saves")))
        _feedbackPython = StateObject(wrappedValue: FeedbackPython(scriptPath: UserDefaults.standard.string(forKey: "mainPath") ?? "/Users/leon/Desktop/Feedback-X/python/code/main.py"))
        _cookiesPython = StateObject(wrappedValue: CookiesPython(scriptPath: UserDefaults.standard.string(forKey: "cookiesPath") ?? "/Users/leon/Desktop/Feedback-X/python/code/main_cookies.py"))
            
        appLaunchCounter += 1
        print("App has launched \(appLaunchCounter) times")
    }
    
    var body: some Scene {
        Window("", id: "FeedbackXMain") {
            SidebarView()
                .sheet(isPresented: $topicShowSheet3, onDismiss: { feedbackPython.stop() }) {
                    TopicSheetView(showSheet: $topicShowSheet3, showSheet2: $CreateshowSheet3, topicSave: $topicSave)
                        .environmentObject(accountLoader)
                        .environmentObject(feedbackPython)
                        .environmentObject(fileLoader)
                }
                .sheet(isPresented: $CreateshowSheet3, onDismiss: { feedbackPython.stop() }) {
                    CreateFeedbackSheetView(showSheet: $CreateshowSheet3, topicSave: $topicSave)
                        .environmentObject(accountLoader)
                        .environmentObject(feedbackPython)
                        .environmentObject(fileLoader)
                }
                .alert("Not enough Accounts", isPresented: $showAccountAlert) {
                    Button("OK", role: .cancel) {}
                } message: {
                    Text("You need to have at least 2 accounts to create feedback. You currently only have \(accountLoader.accounts.count) account(s).")
                }
                .sheet(isPresented: $AccountshowSheet3) {
                    CreateAccountSheetView(showSheet: $AccountshowSheet3)
                        .environmentObject(accountLoader)
                }
                .environmentObject(accountLoader)
                .environmentObject(feedbackPython)
                .environmentObject(cookiesPython)
                .environmentObject(fileLoader)
                .onAppear {
                    reset()
                }
                .onDisappear {
                    reset()
                }
        }
        .commands {
            CommandGroup(replacing: .appTermination) {
                    Button("Quit Feedback X") {
                        reset()
                        NSApplication.shared.windows.forEach { $0.close() }
                        NSApplication.shared.terminate(nil)                     }
                    .keyboardShortcut("q", modifiers: [.command])
                }
           
            
            CommandGroup(replacing: CommandGroupPlacement.appInfo) {
                Button(action: {
                    selectedPageSideBar = "About"
                    OpenHelpWindow.back()
                }) {
                    Text("About Feedback X")
                }
            }
            CommandGroup(replacing: .newItem) {
                Button("New Feedback") {
                    accountLoader.loadAccounts(from: accountURL)
                    if accountLoader.accounts.count >= 2 {
                        if !topicShowSheet3 && !CreateshowSheet3 {
                            topicShowSheet3 = true
                        }
                    } else {
                        showAccountAlert = true
                    }
                }
                .keyboardShortcut("n", modifiers: [.command])
                Divider()
                Button("Add Account") {
                    if !AccountshowSheet3 {
                        AccountshowSheet3 = true
                    }
                }
                .keyboardShortcut("a", modifiers: [.command])
            }
        }
        Settings {
            SettingsView()
                .environmentObject(accountLoader)
                .environmentObject(fileLoader)
        }
    }
}

