//
//  SidebarView.swift
//  Feedback X
//
//  Created by LeonHTM on 15.12.2024.
//  Copyright © 2024 LeonHTM. All rights reserved.
//


import SwiftUI

struct SidebarView: View {
    @State private var selectedPage: String? = "RecentActivity"
    var body: some View {
        NavigationSplitView {
            List(selection: $selectedPage) {
                Section(header: Text("Feedback X")
                    .font(.system(size: 11))
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                ) {
                    NavigationLink(value: "RecentActivity") {
                        Label("Recent Activity", systemImage: "clock")
                            .frame(maxWidth: .infinity, alignment: .leading) // Left-align label text
                    }
                    
                    NavigationLink(value: "FileFeedback") {
                        Label("File Feedback", systemImage: "exclamationmark.bubble")
                            .frame(maxWidth: .infinity, alignment: .leading) // Left-align label text
                    }
                    NavigationLink(value: "Accounts") {
                        Label("Accounts", systemImage: "person")
                            .frame(maxWidth: .infinity, alignment: .leading) // Left-align label text
                    }
                    
                }

                Section(header: Text("Testing")
                    .font(.system(size: 11))
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading) // Ensure the header is left-aligned
                ) {
                    NavigationLink(value: "LoginCycle") {
                        Label("Test Feedback X", systemImage: "bubble.left.and.exclamationmark.bubble.right")
                            .frame(maxWidth: .infinity, alignment: .leading) // Left-align label text
                    }
                    NavigationLink(value: "RewriteCycle") {
                        Label("Test Rewriting", systemImage: "document.on.document")
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
            
        } detail: {
            // Display the appropriate view based on the selected page
            if let selectedPage = selectedPage {
                switch selectedPage {
                case "RecentActivity":
                    CreateFeedbackView()
                case "Accounts":
                    AccountsView()
                case "About":
                    AboutView()
                case "RewriteCycle":
                    TestRewriteView()
                case "LoginCycle":
                    TestLoginView()
                default:
                    CreateFeedbackView() // Default fallback
                }
            } else {
                CreateFeedbackView() // Default view when no page is selected
            }
        }
        .frame(alignment: .leading)

    }
}

#Preview {
    SidebarView()
}
