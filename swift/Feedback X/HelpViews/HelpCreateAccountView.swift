//
//  HelpCreateAccountView.swift
//  Feedback X
//
//  Created by Leon  on 20.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import SwiftUI

struct HelpCreateAccountView: View {
    @Binding var selectedPage: String
    var body: some View {
        VStack{
            Divider()
                            .foregroundStyle(Color.black)
                            .offset(y:8)
            ScrollView{
                
                VStack(alignment:.leading,spacing:15){
                    HStack{
                        Image("FeedbackX256.png")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .shadow(radius: 5)
                        Text("Create Apple Developer Accounts")
                            .font(.title)
                           
                    }.padding(.bottom,10)
                    HStack(alignment:.top,spacing:2){
                        Text("Note:")
                            .italic()
                        Text("Apple limits the creation of Apple Accounts per day with the same phone number. The current Limit is ") +
                                Text("2").bold() +
                        Text(".")
                    }
                    
                    Text("Create an Apple Account on the Web")
                        .fontWeight(.bold)
                        .font(.system(size:15))
                    Image("CreateAccount")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:400)
                        .clipShape(RoundedRectangle(cornerRadius:7))
                    Text("Image: account.apple.com")
                        .foregroundStyle(Color.secondary)
                        .padding(.top,-10)
                    HStack(alignment:.top){
                        Text("1.")
                        Text("Go to https://duckduckgo.com/email/ (Download a Browser that supports Email Protection if necessary).")
                    }
                    HStack(alignment:.top){
                        Text("2.")
                        Text("Create a Duck Adress that relays to an email of your choice (You will have to open a Link sent to your email).")
                    }
                    HStack(alignment:.top){
                        Text("3.")
                        Text("Go to https://duckduckgo.com/email/settings/ and genereate privat duck adresses (write down these adresses somewhere).")
                    }
                    HStack(alignment:.top){
                        Text("4.")
                        Text("Go to https://account.apple.com/account# and create an Apple Account with you phone number and the privat duck adresses you just created.")
                    }
                    HStack(alignment:.top){
                        Text("5.")
                        Text("Sign up for the Apple Developer Programm on https://developer.apple.com/account#.")
                    }.padding(.bottom,10)
                    Text("Create an Apple Account on an Apple Device")
                        .fontWeight(.bold)
                        .font(.system(size:15))
                    Image("CreateAccount2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:400)
                        .clipShape(RoundedRectangle(cornerRadius:7))
                    Text("Image: System Settings on iPhone")
                        .foregroundStyle(Color.secondary)
                        .padding(.top,-10)
                    HStack(alignment:.top,spacing:2){
                        Text("Note:")
                            .italic()
                        Text("Apple limits the creation of Apple Accounts per Apple Device. The current Limit is ") +
                                Text("3").bold() +
                        Text(".")
                    }
                    HStack(alignment:.top){
                        Text("1.")
                        Text("Make sure there is no Apple Account logged into the device. If there is, log out. (On mac you can create a new Account and set it up there).")
                    }
                    HStack(alignment:.top,spacing:0){
                        
                        Text("2.  ")
                        Text("Head to ")
                        Image("SystemSettingsHabibi")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            
                        Text(" > Apple Account > Don't have an Apple Account?")
                    }
                    HStack(alignment:.top){
                        Text("3.")
                        Text("Create an Apple account with a new iCloud mail and your existing phone number.")
                    }
                    HStack(alignment:.top){
                        Text("4.")
                        Text("Sign up for the Apple Developer Programm on https://developer.apple.com/account#.")
                    }
                    Divider()
                    /*Text("Websites mentioned on this page:")
                        .fontWeight(.bold)
                    Link("duckduckgo.com/email",destination: URL(string:"https://duckduckgo.com/email/")!)
                        .padding(.vertical,-5)
                    Link("duckduckgo.com/email/settings",destination: URL(string:"https://duckduckgo.com/email/settings")!)
                    Link("account.apple.com/account#",destination: URL(string:"https://account.apple.com/account#")!)
                        .padding(.vertical,-5)
                    Link("developer.apple.com/account#",destination: URL(string:"https://developer.apple.com/account#")!)
                    Divider()*/
                    Text("See also:")
                        .fontWeight(.bold)
                    Button(action:{
                        
                        selectedPage = "Get Started"
                    }){
                        Text("Get Started with Feedback X")
                            .foregroundStyle(Color.blue)
                    }
                    .padding(.vertical,-5)
                    .buttonStyle(PlainButtonStyle())
                    Button(action:{
                        selectedPage = "Add Accounts"
                    }){
                        Text("Add Accounts to Feedback X")
                            .foregroundStyle(Color.blue)
                    }.buttonStyle(PlainButtonStyle())
                    Button(action:{
                        selectedPage = "Set up Cookies"
                    }){
                        Text("Set up Cookies")
                            .foregroundStyle(Color.blue)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.vertical,-5)
                        
                    
                    
                }.padding()
            }
        }
    }
    
}

#Preview {
    @Previewable @State var text = "Hello, World!"
    HelpCreateAccountView(selectedPage: $text)
}
