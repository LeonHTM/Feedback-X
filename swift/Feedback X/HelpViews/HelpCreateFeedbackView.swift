//
//  HelpCreateFeedbackView.swift
//  Feedback X
//
//  Created by Leon  on 20.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import SwiftUI

struct HelpCreateFeedbackView: View {
    @Binding var selectedPage: String
    @Environment(\.colorScheme) var colorScheme
    @State private var showExample:Bool = false
    @State private var showExampleTitle:Bool = false
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
                        Text("Duplicate Feedback with Feedback X")
                            .font(.title)
                           
                    }.padding(.bottom,10)
                    Text("What is the advantage of duplicating Feedback?")
                        .fontWeight(.bold)
                        .font(.system(size:15))
                    VStack(alignment:.leading){
                        HStack(alignment:.top){
                            Image(systemName:"circle.fill")
                                .font(.system(size:5)).offset(y:4).padding(.trailing,5)
                            Text("In its simplest form the Apple feedback system is pretty simple: The more reports an Issues gets, the likelier it is the get fixed. To increase the chances of your feedback getting fixed, you can duplicate it with Feedback X.")
                        }.padding(.bottom,5)
                        HStack(alignment:.top){
                            Image(systemName:"circle.fill")
                                .font(.system(size:5)).offset(y:4).padding(.trailing,5)
                            Text("You could just send the same Feedback over and over again om the same account, but Apple more or less ignores a feedback if it is a dupicate of antother the account already sent. In the worst case, they even warn you, to only send one feedback for one issue.").padding(.bottom,5)}
                        
                    }
                    Divider()
                    
                    Text("Duplicate Feedback")
                        .fontWeight(.bold)
                        .font(.system(size:15))

                    HStack(alignment:.top){
                        Text("1.")
    
                            HStack{
                                Text("Open Feedback X app")
                                Image("FeedbackX copy 5")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 14, height: 14)
                                    .offset(y:2)
                                    .padding(.trailing,-8)
                                    .padding(.leading,-6)
                                Text(".")
                            }
                        
                    }
                    
                    HStack(alignment:.top){
                        Text("2.")
                        Text("Click  on 'New Feedback 􂛥'.")
                    }
                    HStack(alignment:.top){
                        Text("3.")
                        Text("Choose the topic for your Feedback, then click 'Continue'.")
                    }
                   
                    
                    HStack(alignment:.top){
                        Text("4.")
                        VStack(alignment:.leading){
                            Text("Provide a decriptive title for your feedback.").padding(.bottom,5)
                            Text("The title should be concise, while clearly describing the issue and any factors that could influence the issue you’ve encountered. Summarize and include key details, such as technology, platform, and version.")
                                .padding(.bottom,5)
                            Text("If the issue is related to an app, make sure to also include the app’s name and version.").padding(.bottom,5)
                            Button(action:{
                                
                                showExampleTitle.toggle()
                            }){
                                
                                Text("Show an example title").foregroundStyle(Color.accentColor)
                                Image(systemName: showExampleTitle == true ? "chevron.up" : "chevron.right").foregroundStyle(Color.accentColor)
                            }.buttonStyle(PlainButtonStyle()).padding(.bottom,5)
                            if showExampleTitle == true{
                                Text("App Library Blur displayed incorrectly while swiping in iOS 18.3(22D60)")
                                    .padding(7)
                                    .background(
                                            RoundedRectangle(cornerRadius: 7)
                                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                                .fill(Color.gray.opacity(0.1))
                                           
                                        )
                                    .padding(.bottom,5)
                            }
                            
                            
                        }
                    }
                    Image(colorScheme == .light ? "CreateFeedback2_Light" : "CreateFeedback2_Dark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:400)
                        .clipShape(RoundedRectangle(cornerRadius:7))
                        .overlay(
                                        RoundedRectangle(cornerRadius: 7)
                                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                    )
                    Text("Image: Sheet to enter feedback duplication informations")
                        .foregroundStyle(Color.secondary)
                        .padding(.top,-10)
                    HStack(alignment:.top){
                        Text("5.")
                        VStack(alignment:.leading){
                            Text("Choose the problem area and type of the feedback.")
                                .padding(.bottom,5)
                        }
                    }
                    HStack(alignment:.top){
                        Text("6.")
                        VStack(alignment:.leading){
                            Text("Enter the Feedback path you retrieved earlier in 'Get Feedback Path'.")
                                .padding(.bottom,5)
                        }
                    }
              
                   
                    HStack(alignment:.top){
                        Text("7.")
                        VStack(alignment:.leading){
                            Text("Enter your description.").padding(.bottom,5)
                            Text("Your description should include instructions on how to reproduce the issue, with detailed descriptions of each step.").padding(.bottom,5)
                            Button(action:{
                                
                                showExample.toggle()
                            }){
                                
                                Text("Show an example description").foregroundStyle(Color.accentColor)
                                Image(systemName: showExample == true ? "chevron.up" : "chevron.right").foregroundStyle(Color.accentColor)
                            }.buttonStyle(PlainButtonStyle())
                            
                            if showExample == true{
                                Text("""
The issue occurs when swiping up to exit the App Library. The Borders of the Blur behind the App Library are visible in the left and right bottom corner. This happens because the blur texture is too small.

Reproduce:
Go to App Library.
Swipe up to exit it.
Look at the bottom left corner of the iPhone.
Blur is missing in the corner.

Proposed fix: Make the Blur Texture marginal Bigger

Expected Result:
Border of Blur should not be visible. Like in version prior to iOS 18.0

Device: iPhone 13 Pro
Build: iOS 18.3(22D60)
""").textSelection(.enabled)
                                .padding(7)
                                .background(
                                        RoundedRectangle(cornerRadius: 7)
                                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                            .fill(Color.gray.opacity(0.1))
                                       
                                    )
                                .padding(.top,5)
                            }
                        }
                    }
                  
                    HStack(alignment:.top){
                        Text("8.")
                      
                            Text("In the Attachments section, click ")
                            Image("plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 14, height: 14)
                                .offset(y:2)
                                .padding(.trailing,-8)
                                .padding(.leading,-6)
                            Text(", if you want to add an attachment.")
                        
                        
                    }
                    HStack(alignment:.top){
                        Text("9.")
                        VStack(alignment:.leading){
                            Text("Select the number of feedback duplicates.").padding(.bottom,5)
                            
                            Text("Note:").italic() + Text(" The Slider can max out for values below 10, if you have added less than 10 Accounts.")
                              
                            
                                
                            
                        }
                    }
                    
                    HStack(alignment:.top){
                        Text("10.")
                        VStack(alignment: .leading){
                            Text("Choose the action you want to take with feedback").padding(.bottom,5)
                            Text("Either you submit the duplicated Feedbacks immedediately, or you save them, for manual submission on each account later.")
                        }
                        
                    }
                    HStack(alignment:.top){
                        Text("11.")
                        VStack(alignment:.leading){
                            Text("If you’re ready to duplicate your feedback, click Submit.").padding(.bottom,5)
                            
                            HStack{
                                Text("You must answer all required questions before you can duplicate your feedback. If a required question isn’t answered, it’s flagged with an Arrow").lineLimit(1)
                                Image("arrowright")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 14, height: 14)
                                    
                                    .padding(.trailing,-8)
                                    .padding(.leading,-6)
                                Text(".")
                            }.padding(.bottom,5)
                            Text("Note:").italic() + Text(" There might be a privacy prompt of google chrome that asks you to access your files. You must allow this, or you won't be able to duplicate your feedback.")
                      
                        }
                    }
                    HStack(alignment:.top){
                        Text("12.")
                        VStack(alignment:.leading){
                            Text("If something goes wrong while duplicating, click 'try again'.").padding(.bottom,5)
                            Button(action:{
                                                    
                                                    selectedPage = "Feedback Failed"
                                                }){
                                                    HStack{
                                                        
                                                        Text("Learn about why duplication could have failed")
                                                        Image(systemName:"chevron.right")
                                                        
                                                    }.foregroundStyle(Color.accentColor)
                                                }
                                                .buttonStyle(PlainButtonStyle())
                            
                            
                              
                            
                                
                            
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
                        selectedPage = "Feedback Failed"
                    }){
                        Text("Learn about why duplication could have failed")
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
    HelpCreateFeedbackView(selectedPage: $text)
}
