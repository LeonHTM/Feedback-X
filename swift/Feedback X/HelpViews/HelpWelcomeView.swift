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
    @AppStorage("CreateshowSheet") var CreateshowSheet: Bool = false
    @AppStorage("AccountshowSheet") var AccountshowSheet: Bool = false
    @AppStorage("AccountshowSheet2") var AccountshowSheet2: Bool = false
    @AppStorage("CookiesshowSheet") var CookiesshowSheet: Bool = false
    @AppStorage("SideBarPage") var selectedPageSideBar: String = "Recent Activity"
    var body: some View {
        VStack{
            Divider()
                .foregroundStyle(Color.black)
                .offset(y:8)
            ScrollView{
                VStack(alignment: .leading,spacing:10){
                    HStack{
                        Image("FeedbackX256.png")
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
                    Text("Feedback X is a programm to duplicate Feedbacks inside the Apple Feedback System. The goal of duplicating Bugs is to get more Attention to the bugs that really matter. Feedback X does this by logging into the Feedback Assistant Website on different Apple Accounts and submiting the Feedback each once. The Apple Developer Accounts for this have to be created manually (Apple detects bots creating Apple Accounts) and saved inside the app.")
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
                    Text("Check out the About Section of the Application to find out more about the creation of Feedback X.")
                        .lineLimit(nil)
                    
                    Button(action:{
                        
                        selectedPageSideBar = "About"
                        CreateshowSheet = false
                        AccountshowSheet = false
                        AccountshowSheet2 = false
                        CookiesshowSheet = false
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
                        
                        selectedPageSideBar = "About"
                        CreateshowSheet = false
                        AccountshowSheet = false
                        AccountshowSheet2 = false
                        CookiesshowSheet = false
                    }){
                        HStack{
                            
                            Text("Check out the legal statement")
                            Image(systemName:"chevron.right")
                            
                        }.foregroundStyle(Color.accentColor)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    
                    
                    
                    
                    
                    
                    
                }.padding()
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
