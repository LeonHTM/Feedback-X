//
//  SidebarView.swift
//  Feedback X
//
//  Created by LeonHTM on 15.12.2024.
//  Copyright © 2024 LeonHTM. All rights reserved.
//

import SwiftUI

struct SidebarView: View {
    // App storage properties for sidebar state
    @AppStorage("SideBarPage") var selectedPage: String = "Recent Activity"
    @AppStorage("CreateshowSheet1") var showSheet: Bool = false
    @AppStorage("topicShowSheet1") var topicShowSheet: Bool = false
    @AppStorage("helpSelectedPage") var helpSelectedPage: String = "Welcome"
    
    // State variables for UI interactions
    @State private var showAccountSheet = false
    @State private var showAccountAlert: Bool = false
    @State private var topicSave: String = "iOS & iPadOS"
    
    // Environment objects for managing data
    @EnvironmentObject var accountLoader: AccountLoader
    @EnvironmentObject var feedbackPython: FeedbackPython
    @EnvironmentObject var cookiesPython: CookiesPython
    @EnvironmentObject var fileLoader: FileLoader
    @Environment(\.colorScheme) var colorScheme
    
    // File path for accounts data
    @AppStorage("accountsPath") var accountsPath: String = "/Users/leon/Desktop/Feedback-X/python/accounts/accounts.json"
    var accountURL: URL {
        URL(fileURLWithPath: accountsPath)
    }
    
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selectedPage) {
                // Feedback X Section
                Section(header: Text("Feedback X")
                    .font(.system(size: 11))
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)) {
                    
                    NavigationLink(value: "Recent Activity") {
                        Label("Recent Activity", systemImage: "clock")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    NavigationLink(value: "Accounts") {
                        Label("Accounts", systemImage: "person")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    NavigationLink(value: "Cookies") {
                        Label {
                            Text("Cookies")
                        } icon: {
                            Image("cookies")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 14, height: 14)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
                // About Section
                Section(header: Text("About")
                    .font(.system(size: 11))
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)) {
                    NavigationLink(value: "About") {
                        Label("About", systemImage: "questionmark.circle")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .listStyle(SidebarListStyle())
            .frame(minWidth: 175)
            
            Spacer()
            
            // Help Button
            HStack {
                Spacer()
                Button(action: {
                    helpSelectedPage = "Welcome"
                    OpenHelpWindow.open()
                }) {
                    ZStack {
                        Image(systemName: "circle.fill")
                            .font(.system(size: 15))
                            .foregroundStyle(colorScheme == .dark ? Color.gray.opacity(0.5) : Color.white)
                            .shadow(radius: 1)
                        Text("?")
                            .foregroundStyle(colorScheme == .dark ? Color.white : Color.black)
                            .font(.system(size: 13))
                    }
                    Text("Help me")
                }
                .buttonStyle(PlainButtonStyle())
                .padding([.bottom], 7)
                .padding(.top, 5)
                Spacer()
            }
        } detail: {
            // Display the selected page content
            switch selectedPage {
            case "Recent Activity":
                CombinedView()
                    .environmentObject(accountLoader)
                    .environmentObject(feedbackPython)
                    .environmentObject(fileLoader)
            case "Accounts":
                CombinedAccountsView()
                    .environmentObject(accountLoader)
            case "About":
                AboutView()
            case "Cookies":
                CookiesView()
                    .environmentObject(accountLoader)
                    .environmentObject(cookiesPython)
            case "Test":
                TestRewriteView()
            default:
                CombinedView()
            }
        }
        .frame(alignment: .leading)
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Text(selectedPage)
                    .font(.title3)
                    .bold()
            }
            ToolbarItem(placement: .automatic) {
                Button(action: {
                    accountLoader.loadAccounts(from: accountURL)
                    if accountLoader.accounts.count >= 2 {
                        topicShowSheet = true
                    } else {
                        showAccountAlert = true
                    }
                }) {
                    HStack {
                        Text("New Feedback")
                        Image(systemName: "bubble.and.pencil")
                    }
                }
                .alert("Not enough Accounts", isPresented: $showAccountAlert) {
                    Button("OK", role: .cancel) {}
                } message: {
                    Text("You need at least 2 accounts to create feedback. You currently have \(accountLoader.accounts.count) account(s).")
                }
                .sheet(isPresented: $topicShowSheet, onDismiss: { feedbackPython.stop() }) {
                    TopicSheetView(showSheet: $topicShowSheet, showSheet2: $showSheet, topicSave: $topicSave)
                        .environmentObject(accountLoader)
                        .environmentObject(feedbackPython)
                        .environmentObject(fileLoader)
                }
                .sheet(isPresented: $showSheet, onDismiss: { feedbackPython.stop() }) {
                    CreateFeedbackSheetView(showSheet: $showSheet, topicSave: $topicSave)
                        .environmentObject(accountLoader)
                        .environmentObject(feedbackPython)
                        .environmentObject(fileLoader)
                }
            }
        }
    }
}

