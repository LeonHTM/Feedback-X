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
                        Image("FeedbackX_256")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .shadow(radius: 5)
                        Text("Get Started with Feedback X")
                            .font(.title)
                        
                        
                    }.padding(.bottom,10)
                    Text("Initial Setup")
                        .font(.system(size:15))
                        .fontWeight(.bold)
                    Text("To duplicate feedback with Feedback X, follow these steps (some are only performed once):")
                        .padding(.bottom,5)
                    HStack(alignment:.top){
                        Text("1.")
                        VStack(alignment:.leading,spacing:10){
                            Text("Create Apple Developer Accounts")
                            Text("To send duplicated feedback, you need to add accounts to the application. The duplication will take place on the feedback assistant access of these accounts. These accounts must be created manually at account.apple.com, because apple is really good at detecting bots creating apple accounts.").lineLimit(nil)
                            Button(action:{
                                
                                selectedPage = "Create Accounts"
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
                            Text("After creating the accounts, add them to Feedback X.")
                            
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
                            Text("After adding accounts to Feedback X, set up cookies for each one. This step is crucial to bypass Apple's SMS code requirement every time the programms logs into an apple account in the background.")
                            
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
                            Text("Get Feedback Path & Duplicate Feedbacks")
                            Text("Once all prior steps are complete, you’re ready to duplicate feedback anytime.")
                            
                            Button(action:{
                                
                                selectedPage = "Get Feedback Path"
                            }){
                                HStack{
                                    
                                    Text("Get the Path for any Feedback")
                                    Image(systemName:"chevron.right")
                                    
                                }.foregroundStyle(Color.accentColor)
                            }
                            .buttonStyle(PlainButtonStyle()).padding(.bottom,5)
                            Button(action:{
                                
                                selectedPage = "Duplicate Feedback"
                            }){
                                HStack{
                                    
                                    Text("Duplicate Feedbacks with Feedback X")
                                    Image(systemName:"chevron.right")
                                    
                                }.foregroundStyle(Color.accentColor)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                            
                            
                            
                        
                        
                    }
                    Divider()
                    Text("What if Something Went Wrong?")
                        .font(.system(size:15))
                        .fontWeight(.bold)
                    /*Image("FeedbackFailed")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:400)
                        .clipShape(RoundedRectangle(cornerRadius:7))
                        .overlay(
                                        RoundedRectangle(cornerRadius: 7)
                                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                    )
                    Text("Image: Feedback duplication failed")
                        .foregroundStyle(Color.secondary).padding(.top,-10)*/
                        
                    Text("If feedback duplication fails, visit the Feedback Failed page to understand potential reasons and solutions.")
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
                        selectedPage = "Set up Path"
                    }){
                        Text("Get the path for any feedback")
                            .foregroundStyle(Color.accentColor)
                    }
                    .buttonStyle(PlainButtonStyle())
                   
                    Button(action:{
                        selectedPage = "Duplicate Feedback"
                    }){
                        Text("Duplicate Feedback")
                            .foregroundStyle(Color.accentColor)
                    }.buttonStyle(PlainButtonStyle())
                        .padding(.vertical,-5)
                    
                    Button(action:{
                        selectedPage = "Feedback Failed"
                    }){
                        Text("Feedback Failed")
                            .foregroundStyle(Color.accentColor)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    
                }.padding().textSelection(.enabled)
    
                }
            }.background(colorScheme == .dark ? Color.black.opacity(0.35) : Color.white)
        }
    
}

#Preview {
    @Previewable @State var text = "Hello, World!"
    HelpGetStartedView(selectedPage: $text)
}
