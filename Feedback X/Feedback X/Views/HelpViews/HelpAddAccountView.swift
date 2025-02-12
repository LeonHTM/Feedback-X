//
//  HelpAddAccountView.swift
//  Feedback X
//
//  Created by Leon  on 20.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import SwiftUI

struct HelpAddAccountView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var selectedPage: String
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
                        Text("Add Accounts to Feedback X")
                            .font(.title)
                           
                    }.padding(.bottom,10)
                   
                    
                    Text("Add an Accounts to Feedback X ")
                        .fontWeight(.bold)
                        .font(.system(size:15))
                    Image(colorScheme == .light ? "AddAccount1_Light" : "AddAccount1_Dark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:400)
                        .clipShape(RoundedRectangle(cornerRadius:7))
                        .overlay(
                                        RoundedRectangle(cornerRadius: 7)
                                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                    )
               
                                  
                      
                        
                    Text("Image: Add Account")
                        .foregroundStyle(Color.secondary)
                        .padding(.top,-10)
                    Text("Note:").italic() + Text(" You have to create an Apple Developer Account before adding it to Feedback X.")
                    Button(action:{
                        
                        selectedPage = "Create Accounts"
                    }){
                        HStack{
                            
                            Text("Create Apple Developer Accounts")
                            Image(systemName:"chevron.right")
                            
                        }
                        .foregroundStyle(Color.accentColor)
                        .padding(.top,-10)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .offset(x:38)
                    HStack(alignment:.top){
                        Text("1.")
                        Text("Open the Feedback X app")
                        Image("FeedbackX_32")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 14, height: 14)
                            .offset(y:2)
                            .padding(.trailing,-8)
                            .padding(.leading,-6)
                        Text(".")
                    }
                    HStack(alignment:.top){
                        Text("2.")
                        Text("Select 􀉩 Accounts in the Sidebar.")
                    }
                    HStack(alignment:.top){
                        Text("3.")
                        Text("Click Add Account.")
                    }
                    HStack(alignment:.top){
                        Text("4.")
                        VStack(alignment:.leading){
                            Text("Enter the email adress of the Apple Developer Account you created.").padding(.bottom,5)
                            Text("Each account can only be entered once. If you try to add an account you've already entered, an error message will appear.")
                        }
                    }
                    HStack(alignment:.top){
                        Text("5.")
                        Text("Enter the password of the Apple Developer Account you created.")
                    }
                    HStack(alignment:.top){
                        Text("6.")
                        VStack(alignment:.leading){
                            Text("Choose if the Apple Developer Account you created has Apple Developer.").padding(.bottom,5)
                            Text("You won't be able to set up cookies for the account if it doesn't have Apple Developer. Therefore please set up Apple Developer as soon as possible. Apple Developer can be added at a later point.")
                        }
                    }

                    HStack(alignment:.top){
                        Text("7.")
                        Text("Select the country of origin for the Account.")
                    }
                    HStack(alignment:.top){
                        Text("8.")
                        VStack(alignment: .leading){
                            Text("(Optional) Add notes to the account.").padding(.bottom,5)
                            Text("This is not mandatory and doesn't affect the accounts functionality inside Feedback X.")
                        }
                        
                    }
                    HStack(alignment:.top){
                        Text("9.")
                        VStack(alignment:.leading){
                            Text("If you have filled are the fields, click Save.").padding(.bottom,5)
                            
                            HStack{
                                Text("You must answer all required questions before you can save the account. If a required question isn’t answered, it’s flagged with an Arrow").lineLimit(1)
                                Image("arrowright")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 14, height: 14)
                                    
                                    .padding(.trailing,-8)
                                    .padding(.leading,-6)
                                Text(".")
                            }.padding(.bottom,5)
                              
                            
                                
                            
                        }
                    }
                    HStack(alignment:.top){
                        Text("Note:").italic()
                        Text("You can edit any of the account details at any time by clicking the Edit Button on the top right when displaying an account. ").padding(.leading,-5)
                    }
                    HStack(alignment:.top){
                        Text("Note:").italic()
                        Text("In the current version of this app, passwords are stored in plain text, which means anyone with access to your device can find them if they dig deep enough into the system files. While this isn’t a significant issue if you use passwords that you don’t use elsewhere, please avoid using passwords that you use in other places.").padding(.leading,-5)
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
                        selectedPage = "Create Accounts"
                    }){
                        Text("Create Apple Developer Accounts")
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
    HelpAddAccountView(selectedPage: $text)
}
