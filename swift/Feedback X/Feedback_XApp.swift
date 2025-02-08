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
    @AppStorage("AccountshowSheet3") var AccountshowSheet3: Bool = false
    @AppStorage("topicshowSheet1") var topicShowSheet1:Bool = false
    @AppStorage("topicshowSheet2") var topicShowSheet2:Bool = false
    @AppStorage("CookiesshowSheet") var CookiesshowSheet: Bool = false
    @AppStorage("selectedIndex")  var selectedIndex: Int?
    @AppStorage("selectedIndexActivity")  var selectedIndexActivity: Int?
    @AppStorage("SideBarPage") var selectedPageSideBar: String = "Recent Activity"
    
    let accountURL = URL(fileURLWithPath: "/Users/leon/Desktop/Feedback-X/python/accounts/accounts.json")
    @State private var showAccountAlert: Bool = false
    @State private var topicSave: String = "iOS & iPadOS"
    
    @StateObject private var accountLoader = AccountLoader()
    @StateObject private var feedbackPython = FeedbackPython(scriptPath:"/Users/leon/Desktop/Feedback-X/python/code/main.py")
    @StateObject private var cookiesPython = CookiesPython(scriptPath: "/Users/leon/Desktop/Feedback-X/python/code/main_cookies.py")
    @StateObject private var fileLoader = FileLoader(folderURL: URL(fileURLWithPath: "/Users/leon/Desktop/Feedback-X/python/saves"))
   
    var fullDelete: Bool = true
    func reset(){
        
        CreateshowSheet2 = false
        CreateshowSheet1 = false
        AccountshowSheet1 = false
        CookiesshowSheet = false
        AccountshowSheet2 = false
        topicShowSheet1 = false
        topicShowSheet2 = false
        
        selectedIndex = -1
        selectedIndexActivity = -1
        
        selectedPageSideBar = "Recent Activity"
        
    }

    init() {
        appLaunchCounter += 1
        print("App has launched \(appLaunchCounter) times")
        
    }
    
    var body: some Scene {
        Window("", id: "FeedbackXMain") {
            SidebarView()
                .sheet(isPresented: $topicShowSheet1, onDismiss: { feedbackPython.stop() }) {
                    TopicSheetView(showSheet : $topicShowSheet1, showSheet2: $CreateshowSheet1, topicSave: $topicSave)
                        .environmentObject(accountLoader)
                        .environmentObject(feedbackPython)
                        .environmentObject(fileLoader)
                }
            
                .sheet(isPresented: $CreateshowSheet1, onDismiss: { feedbackPython.stop() }) {
                    CreateFeedbackSheetView(showSheet : $CreateshowSheet1, topicSave: $topicSave)
                        .environmentObject(accountLoader)
                        .environmentObject(feedbackPython)
                        .environmentObject(fileLoader)
                }
                .alert("Not enough Accounts", isPresented: $showAccountAlert) {
                    Button("OK", role: .cancel) {}
                } message: {
                    if accountLoader.accounts.count == 0 {
                        Text("You need to have at least 2 accounts to create feedback. You currently only have \(accountLoader.accounts.count) accounts.")}else{
                            
                            Text("You need to have at least 2 accounts to create feedback. You currently only have \(accountLoader.accounts.count) account.")
                        }
                }
                .sheet(isPresented: $AccountshowSheet3) {
                    CreateAccountSheetView(showSheet: $AccountshowSheet3)
                        .environmentObject(accountLoader)
                }
                .environmentObject(accountLoader)
                .environmentObject(feedbackPython)
                .environmentObject(cookiesPython)
                .environmentObject(fileLoader)
                //.environmentObject(helpSelected)
                .onAppear {
                    //NSWindow.allowsAutomaticWindowTabbing = false
                    reset()
                    
                    
                  
                    
                }
                .onDisappear{
                    
                   reset()
                }
                
        } .commands {
            
            
            
            
            CommandGroup(replacing: .newItem) {  // Replaces "New" section in the "File" menu
                Button("New Feedback") {
                    accountLoader.loadAccounts(from: accountURL)
                    if accountLoader.accounts.count >= 2{
                        if topicShowSheet1 == false && CreateshowSheet1 == false{
                            topicShowSheet1 = true
                        }
                        
                        
                    }else{
                            showAccountAlert = true
                        }
                    
                }
                .keyboardShortcut("n", modifiers: [.command]) // Adds a shortcut ⌘H
                
                
                
                Divider()
                Button("Add Account") {
                    
                    if AccountshowSheet3 == false{
                        AccountshowSheet3 = true
                    }
                    
                }
                .keyboardShortcut("a", modifiers: [.command])
                
               }
            
        }
      
        /*.commands {
            CommandGroup(replacing: .newItem, addition: { })
        }*/
        Settings {
            SettingsView()
                .environmentObject(accountLoader)
                .environmentObject(fileLoader)
                
        }
    }
}



