//
//  HelpSetUpCookiesView.swift
//  Feedback X
//
//  Created by Leon  on 20.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import SwiftUI

struct HelpSetUpCookiesView: View {
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
                        Text("Set Up Cookies in Feedback X")
                            .font(.title)
                           
                    }.padding(.bottom,10)
                    Text("Why do I need to set up Cookies?")
                        .fontWeight(.bold)
                        .font(.system(size:15))
                    VStack(alignment:.leading){
                        HStack(alignment:.top){
                            Image(systemName:"circle.fill")
                                .font(.system(size:5)).offset(y:4).padding(.trailing,5)
                            Text("Feedback X uses a browser enigne to log into the Apple Accounts you provided the Application with. Generally, if anyone logs into the Feedback Assistant site, they need to enter an SMS code that Apple sends to their phone number.")
                        }.padding(.bottom,5)
                        HStack(alignment:.top){
                            Image(systemName:"circle.fill")
                                .font(.system(size:5)).offset(y:4).padding(.trailing,5)
                            Text("After you've entered this SMS Code once and clicked on 'Trust this Browser', the Browser saves cookies for this account and you won't have to enter an SMS Code for 30 Days.").padding(.bottom,5)}
                        HStack(alignment:.top){
                            Image(systemName:"circle.fill")
                                .font(.system(size:5)).offset(y:4).padding(.trailing,5)
                            Text("Since the application cannot enter SMS codes every time it logs in, you must manually save the cookies for each account.")
                        }
                    }
                    Text("Note:").italic()+Text(" Apple limits the amount of cookies saved. The current Limit is ") + Text("10").fontWeight(.bold) + Text(". Meaning you can only duplicate feedback on max 10 Accounts. I might try to circumwent this Limit in future versions of the Application.")
                    Divider()
                    Text("Set Up Cookies")
                        .fontWeight(.bold)
                        .font(.system(size:15))
                   
                        
                    HStack(alignment:.top){
                        Text("1.")
                        Text("Open the Feedback X app")
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
                        Text("Select 􁖩 Cookies in the Sidebar.")
                    }
                    
                    Image(colorScheme == .light ? "Cookies1_Light" : "Cookies1_Dark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:400)
                        .clipShape(RoundedRectangle(cornerRadius:7))
                        .overlay(
                                        RoundedRectangle(cornerRadius: 7)
                                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                    )
               
                                  
                      
                        
                    Text("Image: Cookies Page")
                        .foregroundStyle(Color.secondary)
                        .padding(.top,-10)
                    HStack(alignment:.top){
                        Text("3.")
                        Text("Select the Accounts you want to set up cookies for.")
                    }
                    HStack(alignment:.top){
                        Text("4.")
                        VStack(alignment:.leading){
                            Text("Select the waiting time.").padding(.bottom,5)
                            Text("The waiting time determines how long you have to receive the SMS code, enter it, and click 'Trust.'").padding(.bottom,5)
                            Text("If you need more time than the Slider allows, click on 'More time' and select more time.")
                        }
                    }
                    HStack(alignment:.top){
                        Text("5.")
                        VStack(alignment:.leading){
                            Text("Click on Start.")
                                .padding(.bottom,5)
                            Text("A screen will appear, allowing you to handle cookies setup one account at a time.").padding(.bottom,5)
                            Text("‼️ Do not close the Browser Window until it closes by itsself. It will do this after the waiting time you selected has passed.‼️").bold()
                        }
                    }
                    Image(colorScheme == .light ? "Cookies2_Light" : "Cookies2_Dark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:400)
                        .clipShape(RoundedRectangle(cornerRadius:7))
                        .overlay(
                                        RoundedRectangle(cornerRadius: 7)
                                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                    )
               
                                  
                      
                        
                    Text("Image: Cookies Page")
                        .foregroundStyle(Color.secondary)
                        .padding(.top,-10)
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    HStack(alignment:.top){
                        Text("6.")
                        VStack(alignment:.leading){
                            Text("Click on 'Enable Cookies for [first of the accounts you selected]'.").padding(.bottom,5)
                            Text("This will open a Tab in Google Chrome and log into the selected Account automatically.")
                        }
                    }

                    HStack(alignment:.top){
                        Text("7.")
                        VStack(alignment:.leading){
                            Text("Enter the Code you recieved from Apple per SMS.").padding(.bottom,5)
                            Text("Sometimes the cursor is in the focused on the Adress bar of the browser. You therefore will need to click on the entry squares to focus the Keyboard there.")
                        }
                    }
                    Image("Cookies3")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:400)
                        .clipShape(RoundedRectangle(cornerRadius:7))
                        .overlay(
                                        RoundedRectangle(cornerRadius: 7)
                                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                    )
               
                                  
                      
                        
                    Text("Image: Feedback Asistant page where you enter the SMS code")
                        .foregroundStyle(Color.secondary)
                        .padding(.top,-10)
                    HStack(alignment:.top){
                        Text("8.")
                        VStack(alignment: .leading){
                            Text("Click on 'Trust this Browser'.").padding(.bottom,5)
                        }
                        
                    }
                    HStack(alignment:.top){
                        Text("9.")
                        VStack(alignment:.leading){
                            Text("Wait until the Browser Window closes automatically by itsself. Do not close it by yourself.").padding(.bottom,5)
                            
                            Text("The Browser Window will close after the waiting time you have selected has passed.")
                              
                            
                                
                            
                        }
                    }
                    HStack(alignment:.top){
                        Text("10.")
                        VStack(alignment:.leading){
                            Text("Repeat until all Account have their cookies set up.").padding(.bottom,5)
                            
                            Text("The app tracks your progress and indicates when the setup is complete.").padding(.bottom,5)
                            
                            Text("If you dont recieve the SMS or something else has gone wrong, just click 'Try Again', to try again for the account.")
                              
                            
                                
                            
                        }
                    }
                    
                    HStack(alignment:.top){
                        Text("Note:").italic()
                        Text("The Cookies expire after 30 Days. Feedback X saves the date when account cookies expire. Once cookies expire, the 'Cookies set up' status will automatically change to 'Not set up' , requiring you to redo the process.").padding(.leading,-5)
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
    HelpSetUpCookiesView(selectedPage: $text)
}
