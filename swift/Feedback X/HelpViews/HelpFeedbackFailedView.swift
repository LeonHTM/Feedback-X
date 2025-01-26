//
//  HelpFeedbackFailedView.swift
//  Feedback X
//
//  Created by Leon  on 20.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import SwiftUI

struct HelpFeedbackFailedView: View {
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
                        Image("FeedbackX256.png")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .shadow(radius: 5)
                        Text("Feedback Duplication Failed")
                            .font(.title)
                           
                    }.padding(.bottom,10)
                   
                    
                    Text("What if Feedback Duplication failed? ")
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
                        Text("Go to the Feedback X app")
                        Image("FeedbackX copy 5")
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
                            Text("You can only enter each Account once, if you try to enter an email of an Account you have already added, you will get an error message.")
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
                            Text("You won't be able to set up cookies for the account if it doesn't have Apple Developer. Therefore please set up Apple Developer as soon as possible if you selected 'Not Set Up' and change the setting in Accounts.")
                        }
                    }

                    HStack(alignment:.top){
                        Text("7.")
                        Text("Choose the country of origin you chose for the Account.")
                    }
                    HStack(alignment:.top){
                        Text("8.")
                        VStack(alignment: .leading){
                            Text("If you want to, you can add notes to the account.").padding(.bottom,5)
                            Text("This is not obligatory and doesn't affect the functionality of the account.")
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
                        Text("You can change any of the fields at any time by clicking the Edit Button on an Account. ").padding(.leading,-5)
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
    HelpFeedbackFailedView(selectedPage: $text)
}
