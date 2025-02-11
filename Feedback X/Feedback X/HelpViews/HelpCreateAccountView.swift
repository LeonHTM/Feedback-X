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
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack{
            Divider()
                            .foregroundStyle(Color.black)
                            .offset(y:8)
            ScrollView{
                
                VStack(alignment:.leading,spacing:15){
                    HStack{
                        Image("FeedbackX_256")
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
                    Image("CreateAccount1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:400)
                        .clipShape(RoundedRectangle(cornerRadius:7))
                        .overlay(
                                        RoundedRectangle(cornerRadius: 7)
                                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                    )
                    Text("Image: account.apple.com")
                        .foregroundStyle(Color.secondary)
                        .padding(.top,-10)
                    HStack(alignment:.top){
                        Text("1.")
                        Text("Go to https://duckduckgo.com/email/ (Download a Browser that supports Email Protection if necessary).")
                    }
                    HStack(alignment:.top){
                        Text("2.")
                        Text("Create a Duck Adress that relays to an email of your choice and open the confirmation link sent to your email.")
                    }
                    HStack(alignment:.top){
                        Text("3.")
                        Text("Go to https://duckduckgo.com/email/settings/ and genereate duck mail aliases for the amount of apple accounts you want to create. Be sure to write down these addresses somewhere.")
                    }
                    HStack(alignment:.top){
                        Text("4.")
                        Text("Navigate to https://account.apple.com/#/ and create Apple Accounts using your phone number and the private DuckDuckGo addresses you just generated.")
                    }
                    HStack(alignment:.top){
                        Text("5.")
                        Text("Sign up for the Apple Developer Programm at https://developer.apple.com/account#.")
                    }.padding(.bottom,10)
                    Text("Create an Apple Account on an Apple Device")
                        .fontWeight(.bold)
                        .font(.system(size:15))
                    Image(colorScheme == .light ? "CreateAccount2_Light" : "CreateAccount2_Dark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:400)
                        .clipShape(RoundedRectangle(cornerRadius:7))
                        .overlay(
                                        RoundedRectangle(cornerRadius: 7)
                                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                    )
                    Text("Image: Settings App on iPhone")
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
                        Text("Ensure no Apple Account is logged into the device. If one exists, log out. On macOS, you can create a new user account and set it up there.")
                    }
                    HStack(alignment:.top,spacing:0){
                        
                        Text("2.  ")
                        Text("Head to System Settings ")
                        Image("SettingsIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 14, height: 14)
                            .offset(y: 2)
                            
                        Text(" > Apple Account > Don't have an Apple Account?")
                    }
                    HStack(alignment:.top){
                        Text("3.")
                        Text("Create an Apple account with a new iCloud mail and your existing phone number.")
                    }
                    HStack(alignment:.top){
                        Text("4.")
                        Text("Sign up for the Apple Developer Programm at https://developer.apple.com/account#.")
                    }
                    Divider()
                    Text("See also:")
                        .fontWeight(.bold)
                    Button(action:{
                        
                        selectedPage = "Get Started"
                    }){
                        Text("Get Started with Feedback X")
                            .foregroundStyle(Color.accentColor)
                    }
                    .padding(.vertical,-5)
                    .buttonStyle(PlainButtonStyle())
                    Button(action:{
                        selectedPage = "Add Accounts"
                    }){
                        Text("Add Accounts to Feedback X")
                            .foregroundStyle(Color.accentColor)
                    }.buttonStyle(PlainButtonStyle())
                    Button(action:{
                        selectedPage = "Set up Cookies"
                    }){
                        Text("Set up Cookies")
                            .foregroundStyle(Color.accentColor)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.vertical,-5)
                        
                    
                    
                }.padding().textSelection(.enabled)
            }
        }.background(colorScheme == .dark ? Color.black.opacity(0.35) : Color.white)
    }
    
}

#Preview {
    @Previewable @State var text = "Hello, World!"
    HelpCreateAccountView(selectedPage: $text)
}
