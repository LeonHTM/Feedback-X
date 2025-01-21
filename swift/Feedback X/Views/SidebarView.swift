//
//  SidebarView.swift
//  Feedback X
//
//  Created by LeonHTM on 15.12.2024.
//  Copyright © 2024 LeonHTM. All rights reserved.
//


import SwiftUI

struct SidebarView: View {
    @AppStorage("SideBarPage") var selectedPage: String = "Recent Activity"
    @AppStorage("showSheet") var showSheet: Bool = false
    @State private var showAccountSheet = false
    @State private var showAccountAlert: Bool = false
    
    @EnvironmentObject var accountLoader: AccountLoader
    @EnvironmentObject var feedbackPython: FeedbackPython
    @EnvironmentObject var cookiesPython: CookiesPython
    @EnvironmentObject var fileLoader: FileLoader
    
    let accountURL = URL(fileURLWithPath: "/Users/leon/Desktop/Feedback-X/python/accounts/accounts.json")

    
    var body: some View {
        NavigationSplitView {
            List(selection: $selectedPage) {
                Section(header: Text("Feedback X")
                    .font(.system(size: 11))
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                ) {
                    NavigationLink(value: "Recent Activity") {
                        Label("Recent Activity", systemImage: "clock")
                            .frame(maxWidth: .infinity, alignment: .leading) // Left-align label text
                    }
                    
                    /*NavigationLink(value: "File Feedback") {
                        Label("File Feedback", systemImage: "exclamationmark.bubble")
                            .frame(maxWidth: .infinity, alignment: .leading) // Left-align label text
                    }*/
                    NavigationLink(value: "Accounts") {
                        Label("Accounts", systemImage: "person")
                            .frame(maxWidth: .infinity, alignment: .leading) // Left-align label text
                    }
                    NavigationLink(value: "Cookies") {
                        Label("Cookies", systemImage: "birthday.cake")
                            .frame(maxWidth: .infinity, alignment: .leading) // Left-align label text
                    }
                    
                }
                
                Section(header: Text("About")
                    .font(.system(size: 11))
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading) // Ensure the header is left-aligned
                ) {
                    NavigationLink(value: "About") {
                        Label("About", systemImage: "questionmark.circle")
                            .frame(maxWidth: .infinity, alignment: .leading) // Left-align label text
                    }
                }
                
            }
            .listStyle(SidebarListStyle())
            .frame(minWidth:175)
            
        } detail: {
            // Display the appropriate view based on the selected page
            
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
                case "Rewrite Cycle":
                    TestRewriteView()
                case "Login Cycle":
                    TestLoginView()
                default:
                    CombinedView()
                }
            
        }
        .frame(alignment: .leading)
        .toolbar {
            ToolbarItem(placement: .navigation) {
                    Text(selectedPage ?? "")
                        .font(.title3)
                        .bold()
            }
                
                
            ToolbarItem(placement: .automatic) {
                    
                    Button(action:{
                        accountLoader.loadAccounts(from: accountURL)
                        if accountLoader.accounts.count >= 2{
                            showSheet = true}else{
                                showAccountAlert = true
                            }
                        
                    }){
                        HStack{
                            Text("New Feedback")
                            Image(systemName: "bubble.and.pencil")
                        }
                    }
                    .alert("Not enough Accounts", isPresented: $showAccountAlert) {
                        Button("OK", role: .cancel) {}
                    } message: {
                        if accountLoader.accounts.count == 0 {
                            Text("You need to have at least 2 accounts to create feedback. You currently only have \(accountLoader.accounts.count) accounts.")}else{
                                
                                Text("You need to have at least 2 accounts to create feedback. You currently only have \(accountLoader.accounts.count) account.")
                            }
                    }
                    .sheet(isPresented: $showSheet, onDismiss: { feedbackPython.stop() }) {
                        CreateFeedbackSheetView(showSheet : $showSheet)
                            .environmentObject(accountLoader)
                            .environmentObject(feedbackPython)
                            .environmentObject(fileLoader)
                    }
                
                    
                    
                
            }
        
        }

    }
}

#Preview {
    SidebarView()
}

