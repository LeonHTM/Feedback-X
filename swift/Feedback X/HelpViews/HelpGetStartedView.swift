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
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("showSheet") var showSheet: Bool = false
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
                        Text("Get Started with Feedback X")
                            .font(.title)
                        
                    }.padding(.bottom,10)
                    Text("How to duplicate Feedback?")
                        .font(.system(size:15))
                        .fontWeight(.bold)
                    Text("To duplicate Feedbacks with Feeedback X you have to perform the following steps:")
                        .padding(.bottom,5)
                    HStack(alignment:.top){
                        Text("1.")
                        VStack(alignment:.leading,spacing:10){
                            Text("Create Apple Developer Accounts")
                            Text("To send duplicated Feedback you have to add Accounts to the Application first. These Accounts have to be created manually on account.apple.com. After having been created log into develeoper.apple.com with them to give them access to Feedback Assistant.").lineLimit(nil)
                            Button(action:{
                                
                                selectedPage = "Create Account"
                            }){
                                HStack{
                                    
                                    Text("Create Apple Developer Accounts")
                                    Image(systemName:"chevron.right")
                                    
                                }.foregroundStyle(Color.accentColor)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        
                        
                    }
                    HStack(alignment:.top){
                        Text("2.")
                        VStack(alignment:.leading,spacing:10){
                            Text("Add Apple Developer Accounts to Feedback X")
                            
                            Button(action:{
                                
                                selectedPage = "Add Accounts"
                            }){
                                HStack{
                                    
                                    Text("Add Apple Developer Accounts")
                                    Image(systemName:"chevron.right")
                                    
                                }.foregroundStyle(Color.accentColor)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        
                        
                    }
                    HStack(alignment:.top){
                        Text("3.")
                        VStack(alignment:.leading,spacing:10){
                            Text("Set up Cookies for Apple Accounts")
                            Text("After having added the Accounts to Feedback X you have to set up the cookies for them. This Step is important because if the cookies are not set up Apple wants an SMS Code every time you try to login into a developer Account. With adding cookies for each Apple Account we can circumwent this. Sadly Apple only saves cookies for max. 10 Accounts and I haven't yet found a way to circumwent this Limit. Therefore the Application can only add Cookies for max. 10 Accounts.")
                            
                            Button(action:{
                                
                                selectedPage = "Set up Cookies"
                            }){
                                HStack{
                                    
                                    Text("Set up Cookies")
                                    Image(systemName:"chevron.right")
                                    
                                }.foregroundStyle(Color.accentColor)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        
                        
                    }
                    HStack(alignment:.top){
                        Text("4.")
                        VStack(alignment:.leading,spacing:10){
                            Text("Duplicate Feedbacks")
                            Text("After completing all the prior steps you are ready to duplicate Feedback at any time you want.")
                            
                            Button(action:{
                                
                                selectedPage = "Create Feedback"
                            }){
                                HStack{
                                    
                                    Text("Duplicate Feedbacks with Feedback X")
                                    Image(systemName:"chevron.right")
                                    
                                }.foregroundStyle(Color.accentColor)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        
                        
                    }
                    Text("What if something went wrong?")
                        .font(.system(size:15))
                        .fontWeight(.bold)
                    Image("FeedbackFailed")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:400)
                        .clipShape(RoundedRectangle(cornerRadius:7))
                        .overlay(
                                        RoundedRectangle(cornerRadius: 7)
                                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                    )
                    Text("Image: Feedback duplication failed")
                        .foregroundStyle(Color.secondary).padding(.top,-10)
                        
                    Text("Check out the Feedback Failed page to learn more about why duplication could have failed.")
                    Button(action:{
                        
                        selectedPage = "Feedback Failed"
                    }){
                        HStack{
                            
                            Text("Learn about why duplication could have failed")
                            Image(systemName:"chevron.right")
                            
                        }.foregroundStyle(Color.accentColor)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Divider()
                    Text("See also:")
                        .fontWeight(.bold)
                    Button(action:{
                        
                        selectedPage = "Create Accounts"
                    }){
                        Text("Create Apple Developer Accounts")
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
                    Button(action:{
                        selectedPage = "Create Feedback"
                    }){
                        Text("Duplicate Feedback")
                            .foregroundStyle(Color.accentColor)
                    }.buttonStyle(PlainButtonStyle())
                    Button(action:{
                        selectedPage = "Feedback Failed"
                    }){
                        Text("Feedback Failed")
                            .foregroundStyle(Color.accentColor)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.top,-5)
                    
                }.padding()
    
                }
            }.background(colorScheme == .dark ? Color.black.opacity(0.35) : Color.white)
        }
    
}

#Preview {
    @Previewable @State var text = "Hello, World!"
    HelpGetStartedView(selectedPage: $text)
}
