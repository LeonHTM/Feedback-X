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
                   
                    
                    Text("How to react if feedback duplication failed?")
                        .fontWeight(.bold)
                        .font(.system(size:15))
                    HStack(alignment:.top){
                        Image(systemName:"circle.fill")
                            .font(.system(size:5)).offset(y:4).padding(.trailing,5)
                        Text("If Feedback duplication failed, click 'try again'.")
                    }
                    HStack(alignment:.top){
                        Image(systemName:"circle.fill")
                            .font(.system(size:5)).offset(y:4).padding(.trailing,5)
                        Text("If you additionaly want to see what is going on the browser window accessing the feedback page, click 'Show Browser Window. You might be abke to spot where to programm is going wrong!")
                    }
                    
                    
                    Text("Potential reasons why duplication could have failed")
                        .fontWeight(.bold)
                        .font(.system(size:15))
                    Divider()
                    HStack(alignment:.top){
                        Text("1.")
                        VStack(alignment:.leading, spacing: 10){
                            Text("Invalid Feedback Path")
                            Text("Reason:").bold() + Text(" The feedback path you entered might be incorrect or not formatted as required.")
                            Text("Solution:").bold() + Text("Double-check the feedback path and ensure it matches the structure provided in the Apple Feedback Assistant. For example, a path like 4,1,2 corresponds to the detailed options chosen in the assistant.")
                        }
                       
                    }
                    Divider()
                    HStack(alignment:.top){
                        Text("3.")
                        VStack(alignment:.leading, spacing: 10){
                            Text("Google Chrome doesn't have access to your files")
                            Text("Reason:").bold() + Text(" Feedback X uses Google Chrome in the background. When you add Files to a Feedback Chrome needs access to youe files to add them to the feedback.")
                            HStack(alignment:.top,spacing:0){
                                Text("Solution:").bold() + Text(" Go to Settings ")
                                Image("SettingsIcon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 14, height: 14)
                                    .offset(y: 2)
                                Text(" > Privacy & Security > Files & Folders and allow Files access for all Application called 'Google Chrome for Testing'.")
                            }
                           
                            
                        }
                    }
                    Divider()
                    HStack(alignment:.top){
                        Text("2.")
                        VStack(alignment:.leading, spacing: 10){
                            Text("Cookies are not set up or have expired")
                            Text("Reason:").bold() + Text(" Feedback duplication requires saved cookies to login.")
                            Text("Solution:").bold() + Text(" Go to the page 'Set Up Cookies' and check set up cookies for each acocunt. Either it won't ask for an SMS in which case you can just wait until the window closes again, or you will have to enter an SMS code.")
                            Text("Note:").italic() + Text(" If you want to update the cookie expire date for account which Feedback X still thinks has cookies saved, set the cookies details to 'Not accepted' then set up cookies for the account.")
                            
                        }
                    }
                    Divider()
                    HStack(alignment:.top){
                        Text("3.")
                        VStack(alignment:.leading, spacing: 10){
                            Text("Internet connection issues")
                            Text("Reason:").bold() + Text(" A weak or unstable internet connection might prevent successful submission")
                            Text("Solution:").bold() + Text(" Retry the duplication process once the connection is better. ")
                           
                            
                        }
                    }
                    Divider()
                    HStack(alignment:.top){
                        Text("4.")
                        VStack(alignment:.leading, spacing: 10){
                            Text("Feedback X App Issue")
                            Text("Reason:").bold() + Text(" I am dumb and the App doesn't work like it is supposed to.")
                            Text("Solution:").bold() + Text(" Restart the app and try again.")
                            Text("Note:").italic() + Text(" Make sure to update the application.")
                           
                            
                        }
                    }
                    Divider()
                    HStack(alignment:.top){
                        Text("5.")
                        VStack(alignment:.leading, spacing: 10){
                            Text("MacOS Issue")
                            Text("Reason:").bold() + Text(" Apple is dumb and your macOS has fucked things up.")
                            Text("Solution:").bold() + Text(" Restart your computer and try again.")
                            Text("Note:").italic() + Text(" Never vote for a facist.")
                            
                           
                            
                        }
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
                        selectedPage = "Get Feedback Path"
                    }){
                        Text("Get the Path of any Feedback")
                            .foregroundStyle(Color.accentColor)
                    }.buttonStyle(PlainButtonStyle())
                    Button(action:{
                        selectedPage = "Duplicate Feedback"
                    }){
                        Text("Duplicate Feedback with Feedback X")
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
