//
//  HelpCreateFeedbackView.swift
//  Feedback X
//
//  Created by Leon  on 20.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import SwiftUI

struct HelpGetFeedbackPathView: View {
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
                        Text("Get the Path of any Feedback")
                            .font(.title)
                           
                    }.padding(.bottom,10)
                    Text("Why is the Feedback Path important?")
                        .fontWeight(.bold)
                        .font(.system(size:15))
                    VStack(alignment:.leading){
                        HStack(alignment:.top){
                            Image(systemName:"circle.fill")
                                .font(.system(size:5)).offset(y:4).padding(.trailing,5)
                            Text("The Feedback path is a crucial information for duplicating feedback. It has to be gotten from Feedback Assistant and then entered into Feedback X.")
                        }.padding(.bottom,5)
                        HStack(alignment:.top){
                            Image(systemName:"circle.fill")
                                .font(.system(size:5)).offset(y:4).padding(.trailing,5)
                            Text("The Feedback Path is a simplification of the choices listed under 'Details' when creating a Feedback in the Feedback Assistant. Without the path Feedback X is only able to fill out the area and type of Feedback, but not the Details.").padding(.bottom,5)}
                        
                    }
                    Divider()
                    
                    Text("Get the Feedback Path")
                        .fontWeight(.bold)
                        .font(.system(size:15))
                   
                    /*Image("Cookies1")
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
                        .padding(.top,-10)*/
                        
                    HStack(alignment:.top){
                        Text("1.")
                        VStack(alignment:.leading){
                            HStack{
                                Text("Go to the Apple Feedback Assistant app")
                                Image("FeedbackAssistantIcon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 14, height: 14)
                                    .offset(y:2)
                                    .padding(.trailing,-8)
                                    .padding(.leading,-6)
                                Text(" (Not Feedback X)!")
                            }

                            
                        }
                        
                        
                    }
                    
                    HStack(alignment:.top){
                        Text("2.")
                        Text("Click  on '􂛥'.")
                    }
                    
                    HStack(alignment:.top){
                        Text("3.")
                        Text("Choose the topic for the Issue you want to duplicate with Feedback X, then click 'Continue'.")
                    }
                    HStack(alignment:.top){
                        Text("4.")
                        Text("Choose your problem area and type of feedback for the Issue you want to duplicate with Feedback X.")
                    }
                    HStack(alignment:.top){
                        Text("5.")
                        Text("Fill out the details below area and type for the Issue you want to duplicate with Feedback X.")
                    }
                    
                    HStack(alignment:.top){
                        Text("6.")
                        VStack(alignment:.leading){
                            Text("Get the path of the feedback configuration you just entered.").padding(.bottom,5)
                            Text("The path of your feedback are the options listed as 'Details'.").padding(.bottom,5)
                            (Text("For example, if you chose 'Lock Screen' and 'Incorrect/Unexpected Behaviour', then 'Adding or Editing Lock Screns' and 'Customizing Lock Screen' and 'Font & Color', your path would be 4,1,2.")).padding(.bottom,5)
                            Text("'Adding or Editing Lock Screns' is the fourth option (4) in the first Selector, 'Customizing Lock Screen' is the first option (1) in the second Selector, and 'Font & Color' is the second option (2) in the third and last Selector, the path would therefore be 4,1,2.").padding(.bottom,5)
                        }
                    }
                    Image(colorScheme == .light ? "CreateFeedback3_Light" : "CreateFeedback3_Dark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:400)
                        .clipShape(RoundedRectangle(cornerRadius:7))
                        .overlay(
                                        RoundedRectangle(cornerRadius: 7)
                                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                    )
               
                                  
                        
                    Text("Image: Area & Type selection and below the Selectors that define the path '4,1,2' in the Feedback Assistant App.")
                        .foregroundStyle(Color.secondary)
                        .padding(.top,-10)
                    
                    HStack(alignment:.top){
                        Text("7.")
                        VStack(alignment:.leading){
                            Text("Write down the Feedback Path.").padding(.bottom,5)
                            Text("You can now duplicate Feedbacks for the Issue you wrote down the path for.").padding(.bottom,5)
                            Button(action:{
                                
                                selectedPage = "Duplicate Feedback"
                            }){
                                HStack{
                                    
                                    Text("Duplicate Feedback with Feedback X")
                                    Image(systemName:"chevron.right")
                                    
                                }.foregroundStyle(Color.accentColor)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    HStack(alignment:.top){
                        Text("8.")
                        VStack(alignment:.leading){
                            Text("Finish filing the Feedback and submit it, save it or delete it.").padding(.bottom,5)
                            Text("I personally reccomend submiting the feedback after having filled out everything so that Apple has at least one Feedback with Diagnostic Files for the Issue.")
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
                        selectedPage = "Create Accounts"
                    }){
                        Text("Create Apple Developer Accounts")
                            .foregroundStyle(Color.accentColor)
                    }.buttonStyle(PlainButtonStyle())
                    Button(action:{
                        selectedPage = "Add Accounts"
                    }){
                        Text("Add Accounts to Feedback X")
                            .foregroundStyle(Color.accentColor)
                    }.buttonStyle(PlainButtonStyle())
                        .padding(.vertical,-5)
                    Button(action:{
                        selectedPage = "Set up Cookies"
                    }){
                        Text("Set up Cookies")
                            .foregroundStyle(Color.accentColor)
                    }
                    .buttonStyle(PlainButtonStyle())
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
    HelpGetFeedbackPathView(selectedPage: $text)
}
