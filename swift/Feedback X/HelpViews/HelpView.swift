//
//  HelpMeView.swift
//  Feedback X
//
//  Created by Leon  on 19.12.2024.
//  Copyright © 2024 LeonHTM. All rights reserved.
//


import SwiftUI

struct HelpView: View {
    @State public var selectedPage: String = "Recent Activity"
    @State private var expandedParents: Set<String> = []
    @State private var visibility: NavigationSplitViewVisibility = .all

    // Hierarchical data structure for the sidebar
    struct SidebarItem: Identifiable {
        var id = UUID()
        var name: String
        var children: [SidebarItem]?
    }

    let items = [
        SidebarItem(name: "Welcome", children: nil),
        SidebarItem(name: "Overview", children: [
            SidebarItem(name: "Get Started", children: nil)
        ]),
        SidebarItem(name: "Accounts", children: [
            SidebarItem(name: "Create Accounts", children: nil),
            SidebarItem(name: "Add Accounts", children: nil),
            SidebarItem(name: "Set up Cookies", children: nil)
        ]),
        SidebarItem(name: "Create Feedback", children: [
            SidebarItem(name: "Create Feedback", children: nil),
            SidebarItem(name: "Feedback Failed", children: nil)
        ])
    ]

    var body: some View {
        NavigationSplitView(columnVisibility: $visibility) {
            List(selection: $selectedPage) {
                ForEach(items) { item in
                    if let children = item.children, !children.isEmpty {
                        // Parent item with children, make the entire row clickable to expand/collapse
                        Button(action: {
                            if expandedParents.contains(item.name) {
                                expandedParents.remove(item.name)
                            } else {
                                expandedParents.insert(item.name)
                            }
                        }) {
                            HStack(spacing:0) {
                                Image(systemName: expandedParents.contains(item.name) ? "chevron.down" : "chevron.right")
                                    .padding(.trailing, 2)
                                    .foregroundStyle(Color.secondary)
                                    .font(.system(size: 10))
                                Text(item.name)
                                    //.frame(maxWidth: .infinity, alignment: .leading)
                                
                            }
                            
                        }.buttonStyle(PlainButtonStyle())
                        
                        // Show children if expanded
                        if expandedParents.contains(item.name) {
                            ForEach(children) { child in
                                NavigationLink(value: child.name) {
                                    Text(child.name)
                                        .offset(x:25)
                                        //.frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                        }
                    } else {
                        // Leaf node (no children), just a NavigationLink
                        NavigationLink(value: item.name) {
                            Text(item.name)
                                //.frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
            }
            .listStyle(SidebarListStyle()) // Clean style
            .frame(minWidth: 175)
        } detail: {
            // Display the appropriate view based on the selected page
            
                switch selectedPage {
                case "Welcome":
                    HelpWelcomeView(selectedPage: $selectedPage, visibility: $visibility)
                case "Get Started":
                    HelpGetStartedView(selectedPage: $selectedPage)
                case "Create Accounts":
                    HelpCreateAccountView(selectedPage: $selectedPage)
                case "Add Accounts":
                    HelpAddAccountView(selectedPage: $selectedPage)
                case "Set up Cookies":
                    HelpSetUpCookiesView(selectedPage: $selectedPage)
                case "Create Feedback":
                    HelpCreateAccountView(selectedPage: $selectedPage)
                case "Feedback Failed":
                    HelpFeedbackFailedView(selectedPage: $selectedPage)
                default:
                    HelpWelcomeView(selectedPage: $selectedPage, visibility: $visibility)
                }
            
        }
        .frame(alignment: .leading)
        .toolbar {
          
                
            ToolbarItem(placement: .navigation) {
                    
                    Button(action:{
                        
                        withAnimation{
                            if visibility == .all{
                                visibility = .detailOnly
                            }else if visibility == .detailOnly{
                                visibility = .all
                            }
                        }
                       
                    }){
                        
                  
                        Image(systemName: "sidebar.left")
                        
                    }
                   
                    
                    
                
            }
        
        }
        
        
        
    }
}

#Preview {
    HelpView()
}
