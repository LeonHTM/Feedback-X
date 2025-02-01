//
//  HelpMeView.swift
//  Feedback X
//
//  Created by Leon  on 19.12.2024.
//  Copyright © 2024 LeonHTM. All rights reserved.
//


import SwiftUI

struct HelpView: View {
    
    @AppStorage("helpSelectedPage") var helpSelectedPage: String = "Welcome"
  
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
            //SidebarItem(name: "Feedback System", children: nil)
            
        ]),
        SidebarItem(name: "Accounts", children: [
            SidebarItem(name: "Create Accounts", children: nil),
            SidebarItem(name: "Add Accounts", children: nil),
            SidebarItem(name: "Set up Cookies", children: nil)
        ]),
        SidebarItem(name: "Feedbacks", children: [
            SidebarItem(name: "Get Feedback Path", children: nil),
            SidebarItem(name: "Duplicate Feedback", children: nil),
            SidebarItem(name: "Feedback Failed", children: nil)
        ])
    ]

    var body: some View {
        NavigationSplitView(columnVisibility: $visibility) {
            Button(action:{
                
                withAnimation{
                    if visibility == .all{
                        visibility = .detailOnly
                    }else if visibility == .detailOnly{
                        visibility = .all
                    }
                }
               
            }){
                
                HStack{
                    Image(systemName: "sidebar.left")
                        .font(.system(size: 18))
                        .padding(.leading,75)
                    Spacer()
                }

                    
            }
            .buttonStyle(PlainButtonStyle())
            .offset(x:20,y:-35)
            .foregroundStyle(.secondary)
            
            List(selection: $helpSelectedPage) {
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
                            .onChange(of: helpSelectedPage) {
                                func findParent(of page: String, in items: [SidebarItem], parentName: String? = nil) -> String? {
                                    for item in items {
                                        if item.name == page {
                                            return parentName
                                        }
                                        if let children = item.children {
                                            if let parent = findParent(of: page, in: children, parentName: item.name) {
                                                return parent
                                            }
                                        }
                                    }
                                    return nil
                                }
                                
                                if let parent = findParent(of: helpSelectedPage, in: items) {
                                    expandedParents.insert(parent)
                                }
                            }
                            .onAppear() {
                                func findParent(of page: String, in items: [SidebarItem], parentName: String? = nil) -> String? {
                                    for item in items {
                                        if item.name == page {
                                            return parentName
                                        }
                                        if let children = item.children {
                                            if let parent = findParent(of: page, in: children, parentName: item.name) {
                                                return parent
                                            }
                                        }
                                    }
                                    return nil
                                }
                                
                                if let parent = findParent(of: helpSelectedPage, in: items) {
                                    expandedParents.insert(parent)
                                }
                            }
                        
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
            .frame(minWidth: 180)
        } detail: {
            // Display the appropriate view based on the selected page
            
            switch helpSelectedPage{
            case "Welcome":
                HelpWelcomeView(selectedPage: $helpSelectedPage, visibility: $visibility)
            case "Get Started":
                HelpGetStartedView(selectedPage: $helpSelectedPage)
            case "Feedback System":
                HelpFeedbackSystemView(selectedPage: $helpSelectedPage)
            case "Create Accounts":
                HelpCreateAccountView(selectedPage: $helpSelectedPage)
            case "Add Accounts":
                HelpAddAccountView(selectedPage: $helpSelectedPage)
            case "Set up Cookies":
                HelpSetUpCookiesView(selectedPage: $helpSelectedPage)
            case "Duplicate Feedback":
                HelpCreateFeedbackView(selectedPage: $helpSelectedPage)
            case "Get Feedback Path":
                HelpGetFeedbackPathView(selectedPage: $helpSelectedPage)
            case "Feedback Failed":
                HelpFeedbackFailedView(selectedPage: $helpSelectedPage)
            default:
                HelpWelcomeView(selectedPage: $helpSelectedPage, visibility: $visibility)
            }
            
        }
        .onDisappear{
            
            OpenHelpWindow.resetLaunchStatus()
        }
        .navigationSplitViewStyle(.automatic)
        .frame(alignment: .leading)
        
        .toolbar{
          
            
            ToolbarItem(placement: .navigation) {
                if visibility == .detailOnly {
                    Button(action: {
                        // Add a delay before updating the visibility
                        // Adjust the delay as needed (0.5 seconds here)
                            withAnimation {
                                //DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    if visibility == .all {
                                        visibility = .detailOnly
                                    } else if visibility == .detailOnly {
                                        visibility = .all
                                    }
                                //}
                            }
                        
                    }) {
                        
                            Image(systemName: "sidebar.left")
                            
                            
                        
                    }
                } else {
                    Text("")
                }
            }

        
        }
        .frame(minWidth:1125,minHeight:600)
        
        
        
    }
}

#Preview {
    @Previewable @State var text = "Welcome"
    HelpView()
}
