//
//  SidebarView.swift
//  Feedback X
//
//  Created by LeonHTM on 15.12.2024.
//  Copyright © 2024 LeonHTM. All rights reserved.
//


import SwiftUI

struct SidebarView: View {
    @State private var selectedPage: String? = "Recent Activity"
    @State private var showSheet =  false
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
                    
                }

                Section(header: Text("Testing")
                    .font(.system(size: 11))
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading) // Ensure the header is left-aligned
                ) {
                    NavigationLink(value: "Login Cycle") {
                        Label("Test Feedback X", systemImage: "bubble.left.and.exclamationmark.bubble.right")
                            .frame(maxWidth: .infinity, alignment: .leading) // Left-align label text
                    }
                    NavigationLink(value: "Rewrite Cycle") {
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
            .frame(minWidth:175)
            
        } detail: {
            // Display the appropriate view based on the selected page
            if let selectedPage = selectedPage {
                switch selectedPage {
                case "Recent Activity":
                    CombinedView()
                case "Accounts":
                    CombinedAccountView()
                case "About":
                    AboutView()
                case "Rewrite Cycle":
                    TestRewriteView()
                case "Login Cycle":
                    TestLoginView()
                default:
                    CombinedView() 
                }
            } else {
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
                        showSheet = true
                        
                    }){
                        HStack{
                            Text("New Feedback")
                            Image(systemName: "bubble.and.pencil")
                        }
                    }
                    .sheet(isPresented: $showSheet) {
                        CreateFeedbackSheetView(showSheet : $showSheet)
                        
                    }
                
                    
                    
                
            }
        }

    }
}

#Preview {
    SidebarView()
}

