//
//  HelpMeGetStartedView.swift
//  Feedback X
//
//  Created by Leon  on 20.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import SwiftUI

struct HelpGetStartedView: View {
    @Binding var selectedPage: String
    @AppStorage("showSheet") var showSheet: Bool = false
    var body: some View {
        ScrollView{
            VStack(alignment:.leading,spacing:5){
                HStack{
                    Image("FeedbackX256.png")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .shadow(radius: 5)
                    Text("Get Started with Feedback X")
                        .font(.title)
                        .fontWeight(.bold)
                }
                .padding(.bottom,20)
                Text("How to send duplicated Feedback?")
                    .font(.title3)
                    .fontWeight(.bold)
                Text("To send duplicated Feedbacks with Feeedback X you have to perform the following steps first:")
                    .padding(.bottom,5)
                Text("1) Create Apple Account on account.apple.com")
                    .font(.headline)
                
                Text("To send duplicated Feedback you have to add Accounts to the Application first. These Accounts have to be created manually on account.apple.com. After having been created log into develeoper.apple.com with them to give them access to Feedback Assistant.").lineLimit(nil)
                    .offset(x:15)
                Button(action:{
                    
                    selectedPage = "Create Accounts"
                }){
                    HStack{
                        
                        Text("Create Accounts on account.apple.com")
                        Image(systemName:"chevron.right")
                        
                    }.foregroundStyle(Color.accentColor)
                }
                .buttonStyle(PlainButtonStyle())
                .offset(x:15)
                Text("2) Add Account you created to Feedback X")
                    .font(.headline)
                
                Text("You can then add the Apple Accounts you created to Feedback X.")
                    .lineLimit(nil)
                    .offset(x:15)
                Button(action:{
                    
                    selectedPage = "Add Accounts"
                }){
                    HStack{
                        
                        Text("Add Apple Accounts to Feedback X")
                        Image(systemName:"chevron.right")
                        
                    }.foregroundStyle(Color.accentColor)
                }
                .buttonStyle(PlainButtonStyle())
                .offset(x:15)
                Text("3) Set up Cookies for Apple Accounts you created")
                    .font(.headline)
                Text("After having added the Accounts to Feedback X you have to set up the cookies for them. This Step is important because if the cookies are not set up Apple wants an SMS Code every time you try to login into a developer Account. With adding cookies for each Apple Account we can circumwent this. Sadly Apple only saves cookies for max. 10 Accounts and I haven't yet found a way to circumwent this Limit. Therefore the Application can only add Cookies for max. 10 Accounts.")
                    .lineLimit(nil)
                    .offset(x:15)
                Button(action:{
                    
                    selectedPage = "Set up Cookies"
                }){
                    HStack{
                        
                        Text("Set Up Cookies for Accounts")
                        Image(systemName:"chevron.right")
                        
                    }.foregroundStyle(Color.accentColor)
                }
                .buttonStyle(PlainButtonStyle())
                .offset(x:15)
                Text("4) Duplicate Feedback")
                    .font(.headline)
                Text("After completing all the prior steps you are ready to duplicate Feedback.")
                    .lineLimit(nil)
                    .offset(x:15)
                Button(action:{
                    
                    selectedPage = "Create Feedback"
                }){
                    HStack{
                        
                        Text("Duplicate Feedback with Feedback X")
                        Image(systemName:"chevron.right")
                        
                    }.foregroundStyle(Color.accentColor)
                }
                .buttonStyle(PlainButtonStyle())
                .offset(x:15)
                
                Text("5) Something has gone wrong")
                    .font(.headline)
                Text("Check out the troubleshooting guide for more information.")
                    .lineLimit(nil)
                    .offset(x:15)
                
                Button(action:{
                    
                    selectedPage = "Feedback Failed"
                }){
                    HStack{
                        
                        Text("Learn about why duplication could have failed")
                        Image(systemName:"chevron.right")
                        
                    }.foregroundStyle(Color.accentColor)
                }
                .buttonStyle(PlainButtonStyle())
                .offset(x:15)
            }.padding()
        }
    }
}

#Preview {
    @Previewable @State var text = "Hello, World!"
    HelpGetStartedView(selectedPage: $text)
}
