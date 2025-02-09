//
//  HelpMe1.swift
//  Feedback X
//
//  Created by Leon  on 20.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import SwiftUI

struct HelpWelcomeView: View {
    @Binding var selectedPage: String
    @Environment(\.colorScheme) var colorScheme
    @Binding var visibility: NavigationSplitViewVisibility
    @AppStorage("CreateshowSheet1") var CreateshowSheet1: Bool = false
    @AppStorage("CreateshowSheet2") var CreateshowSheet2: Bool = false
    @AppStorage("CreateshowSheet3") var CreateshowSheet3: Bool = false
    @AppStorage("AccountshowSheet1") var AccountshowSheet1: Bool = false
    @AppStorage("AccountshowSheet2") var AccountshowSheet2: Bool = false
    @AppStorage("AccountshowSheet3") var AccountshowSheet3: Bool = false
    @AppStorage("topicshowSheet1") var topicshowSheet1: Bool = false
    @AppStorage("topicshowSheet2") var topicshowSheet2: Bool = false
    @AppStorage("topicshowSheet3") var topicshowSheet3: Bool = false
    @AppStorage("CookiesshowSheet") var CookiesshowSheet: Bool = false
    @AppStorage("SideBarPage") var selectedPageSideBar: String = "Recent Activity"
    @AppStorage("aboutSelectedPage") var aboutSelectedPage: String = "Privacy"
    
    
    func focusaway(){
        selectedPageSideBar = "About"
        CookiesshowSheet = false
        
        CreateshowSheet1 = false
        CreateshowSheet2 = false
        CreateshowSheet3 = false
        
        topicshowSheet1 = false
        topicshowSheet2 = false
        topicshowSheet3 = false
        
        AccountshowSheet1 = false
        AccountshowSheet2 = false
        AccountshowSheet3 = false
        OpenHelpWindow.back()
    }
    
    
    var body: some View {
        VStack{
            Divider()
                .foregroundStyle(Color.black)
                .offset(y:8)
            ScrollView{
                VStack(alignment: .leading,spacing:10){
                    HStack{
                        Image("FeedbackX_256")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 75, height: 75)
                            .shadow(radius: 5)
                        
                        VStack(alignment:.leading,spacing:10){
                            Text("Feedback X User Guide")
                                .font(.title)
                                .fontWeight(.bold)
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
                                    Image(systemName:"sidebar.left")
                                    Text("Table of Contents")
                                }.foregroundStyle(Color.accentColor)
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }
                    
                    Divider()
                    Text("What is Feedback X used for?")
                        .font(.title3)
                        .fontWeight(.bold)
                    Text("Feedback X is a program designed to duplicate feedback within the Apple Feedback System. Its goal is to draw more attention to bugs that truly matter by duplicating feedback submissions. Feedback X achieves this by logging into the Feedback Assistant website using multiple Apple accounts and submitting each piece of feedback once.")
                        .lineLimit(nil)
                    
                    Button(action:{
                        
                        selectedPage = "Get Started"
                    }){
                        HStack{
                            
                            Text("Get Started with Feedback X")
                            Image(systemName:"chevron.right")
                            
                        }.foregroundStyle(Color.accentColor)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Divider()
                    Text("Who created Feedback X?")
                        .font(.title3)
                        .fontWeight(.bold)
                    Text("For more information about the creation of Feedback X, visit the ") + Text("About").bold() + Text(" page.")
                 
                    
                    Button(action:{
                        
                        focusaway()
                        
                       
                    }){
                        HStack{
                            
                            Text("Visit the About Page")
                            Image(systemName:"chevron.right")
                            
                        }.foregroundStyle(Color.accentColor)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Divider()
                    Text("Legal")
                        .font(.title3)
                        .fontWeight(.bold)
                    Text("""
                     This app is provided as is, without any guarantees or warranties. The developer does not accept any responsibility for any actions taken by users of this app. By using this app, you agree to use it at your own risk. You acknowledge and agree that you are solely responsible for any actions taken using this program. The developer and any associated parties are not liable for any consequences arising from the use of this program. Your use of the program indicates your acceptance of these terms.
                     """)
                    .lineLimit(nil)
                    Button(action:{
                        
                        focusaway()
                        aboutSelectedPage = "Legal"
                    }){
                        HStack{
                            
                            Text("Check out the legal statement")
                            Image(systemName:"chevron.right")
                            
                        }.foregroundStyle(Color.accentColor)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    
                    
                    
                    
                    
                    
                    
                }.padding().textSelection(.enabled)
                Spacer()
            }
        }.background(colorScheme == .dark ? Color.black.opacity(0.35) : Color.white)
    }
}

#Preview {
    @Previewable @State var text = "Hello, World!"
    @Previewable @State var visibility: NavigationSplitViewVisibility = .all
    HelpWelcomeView(selectedPage: $text,visibility: $visibility)
}
