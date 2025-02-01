//
//  TopicSheetView.swift
//  Feedback X
//
//  Created by Leon  on 24.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import SwiftUI

struct TopicSheetView: View {
    @Binding var showSheet: Bool
    @Binding var showSheet2: Bool
    @Binding var topicSave: String
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("helpSelectedPage") var helpSelectedPage: String = "Choose Topic"
    @EnvironmentObject var accountLoader: AccountLoader
    @EnvironmentObject var feedbackPython: FeedbackPython
    @EnvironmentObject var fileLoader : FileLoader
    
    var body: some View {
      
            
        VStack(alignment:.leading){
            VStack(alignment:.leading){
                Text("What are you seeing an Issue with?")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top,50)
                    .padding(.bottom,-5)
                
                //To any possible reader: Im kinda ashamed how inefficient I coded this i just should have made a ForEach or a Set but it is what it is i guess - LeonHTM
                
                ScrollView{
                    
                    VStack(alignment: .leading){
                        Button(action:{
                            topicSave = "iOS & iPadOS"
                        }){
                            HStack{
                                VStack(alignment:.leading){
                                    Text("iOS & iPadOS")
                                        .foregroundStyle(topicSave == "iOS & iPadOS" ? Color.white : Color.primary)
                                    Text("iOS & iPadOS features, apps, and devices")
                                        .foregroundStyle(topicSave == "iOS & iPadOS" ? Color.white : Color.secondary)
                                        .font(.system(size: 10))
                                }
                                Spacer()
                            }
                            .padding(.leading,24)
                            .padding(.vertical,10)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(topicSave == "iOS & iPadOS" ? Color.accentColor : (colorScheme == .dark ? Color.black.opacity(0.15) : Color.white))
                                
                            )
                            .padding(.horizontal,10)
                            .padding(.top,12)
                        }.buttonStyle(PlainButtonStyle())
                     
                        Button(action:{
                            topicSave = "macOS"
                        }){
                            HStack{
                                VStack(alignment:.leading,spacing:1){
                                    Text("macOS")
                                        .foregroundStyle(topicSave == "macOS" ? Color.white : Color.primary)
                                    Text("macOS features, apps and, devices")
                                        .foregroundStyle(topicSave == "macOS" ? Color.white : Color.secondary)
                                        .font(.system(size: 10))
                                }
                                Spacer()
                            }
                            .padding(.leading,24)
                            .padding(.vertical,10)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(topicSave == "macOS" ? Color.accentColor : Color.gray.opacity(0.1))
                                
                            )
                            .padding(.horizontal,10)
                            .padding(.top,-7.3)
                        }.buttonStyle(PlainButtonStyle())
                        
                        Button(action:{
                            topicSave = "tvOS"
                        }){
                            HStack{
                                VStack(alignment:.leading,spacing:1){
                                    Text("tvOS")
                                        .foregroundStyle(topicSave == "tvOS" ? Color.white : Color.primary)
                                    Text("tvOS features, apps and, devices")
                                        .font(.system(size: 10))
                                        .foregroundStyle(topicSave == "tvOS" ? Color.white : Color.secondary)
                                        
                                }
                                Spacer()
                            }
                            .padding(.leading,24)
                            .padding(.vertical,10)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(topicSave == "tvOS" ? Color.accentColor : (colorScheme == .dark ? Color.black.opacity(0.15) : Color.white))
                                
                            )
                            .padding(.horizontal,10)
                            .padding(.top,-7.3)
                        }.buttonStyle(PlainButtonStyle())
                        
                        Button(action:{
                            topicSave = "visionOS"
                        }){
                            HStack{
                                VStack(alignment:.leading,spacing:1){
                                    Text("visionOS")
                                        .foregroundStyle(topicSave == "visionOS" ? Color.white : Color.primary)
                                    Text("visionOS features, apps and, devices")
                                        .font(.system(size: 10))
                                        .foregroundStyle(topicSave == "visionOS" ? Color.white : Color.secondary)
                                        
                                }
                                Spacer()
                            }
                            .padding(.leading,24)
                            .padding(.vertical,10)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(topicSave == "visionOS" ? Color.accentColor : Color.gray.opacity(0.1))
                                
                            )
                            .padding(.horizontal,10)
                            .padding(.top,-7.3)
                        }.buttonStyle(PlainButtonStyle())
                        
                        Button(action:{
                            topicSave = "watchOS"
                        }){
                            HStack{
                                VStack(alignment:.leading,spacing:1){
                                    Text("watchOS")
                                        .foregroundStyle(topicSave == "watchOS" ? Color.white : Color.primary)
                                    Text("watchOS features, apps and, devices")
                                        .font(.system(size: 10))
                                        .foregroundStyle(topicSave == "watchOS" ? Color.white : Color.secondary)
                                        
                                }
                                Spacer()
                            }
                            .padding(.leading,24)
                            .padding(.vertical,10)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(topicSave == "watchOS" ? Color.accentColor : (colorScheme == .dark ? Color.black.opacity(0.15) : Color.white))
                                
                            )
                            .padding(.horizontal,10)
                            .padding(.top,-7.3)
                        }.buttonStyle(PlainButtonStyle())
                        Button(action:{
                            topicSave = "HomePod"
                        }){
                            HStack{
                                VStack(alignment:.leading,spacing:1){
                                    Text("HomePod")
                                        .foregroundStyle(topicSave == "HomePod" ? Color.white : Color.primary)
                                    Text("HomePod features, apps and, devices")
                                        .font(.system(size: 10))
                                        .foregroundStyle(topicSave == "HomePod" ? Color.white : Color.secondary)
                                        
                                }
                                Spacer()
                            }
                            .padding(.leading,24)
                            .padding(.vertical,10)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(topicSave == "HomePod" ? Color.accentColor : Color.gray.opacity(0.1))
                                
                            )
                            .padding(.horizontal,10)
                            .padding(.top,-7.3)
                        }.buttonStyle(PlainButtonStyle())
                        Button(action:{
                            topicSave = "AirPods Beta Firmware"
                        }){
                            HStack{
                                VStack(alignment:.leading,spacing:1){
                                    Text("Airpods Beta Firmware")
                                        .foregroundStyle(topicSave == "AirPods Beta Firmware" ? Color.white : Color.primary)
                                    Text("AirPods Firmware features and, devices")
                                        .font(.system(size: 10))
                                        .foregroundStyle(topicSave == "Airpods Beta Firmware" ? Color.white : Color.secondary)
                                        
                                }
                                Spacer()
                            }
                            .padding(.leading,24)
                            .padding(.vertical,10)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(topicSave == "AirPods Beta Firmware" ? Color.accentColor : (colorScheme == .dark ? Color.black.opacity(0.15) : Color.white))
                                
                            )
                            .padding(.horizontal,10)
                            .padding(.top,-7.3)
                        }.buttonStyle(PlainButtonStyle())
                        Button(action:{
                            topicSave = "Developer Technologies & SDKs"
                        }){
                            HStack{
                                VStack(alignment:.leading,spacing:1){
                                    Text("Developer Technologies & SDKs")
                                        .foregroundStyle(topicSave == "Developer Technologies & SDKs" ? Color.white : Color.primary)
                                    Text("APIs and Frameworks for all Apple Platforms")
                                        .font(.system(size: 10))
                                        .foregroundStyle(topicSave == "Developer Technologies & SDKs" ? Color.white : Color.secondary)
                                        
                                }
                                Spacer()
                            }
                            .padding(.leading,24)
                            .padding(.vertical,10)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(topicSave == "Developer Technologies & SDKs" ? Color.accentColor : Color.gray.opacity(0.1))
                                
                            )
                            .padding(.horizontal,10)
                            .padding(.top,-7.3)
                        }.buttonStyle(PlainButtonStyle())
                        Button(action:{
                            topicSave = "Developer Tools & Resources"
                        }){
                            HStack{
                                VStack(alignment:.leading,spacing:1){
                                    Text("Developer Tools & Resources")
                                        .foregroundStyle(topicSave == "Developer Tools & Resources" ? Color.white : Color.primary)
                                    Text("Xcode, App Store Connect, Apple Developer Resources")
                                        .font(.system(size: 10))
                                        .foregroundStyle(topicSave == "Developer Tools & Resources" ? Color.white : Color.secondary)
                                        
                                }
                                Spacer()
                            }
                            .padding(.leading,24)
                            .padding(.vertical,10)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(topicSave == "Developer Tools & Resources" ? Color.accentColor : (colorScheme == .dark ? Color.black.opacity(0.15) : Color.white))
                                
                            )
                            .padding(.horizontal,10)
                            .padding(.top,-7.3)
                        }.buttonStyle(PlainButtonStyle())
                        Button(action:{
                            topicSave = "Enterprise & Education"
                        }){
                            HStack{
                                VStack(alignment:.leading,spacing:1){
                                    Text("Enterprise & Education")
                                        .foregroundStyle(topicSave == "Enterprise & Education" ? Color.white : Color.primary)
                                    Text("MDM, enterprise and education programs and apps, training and certificaion")
                                        .font(.system(size: 10))
                                        .foregroundStyle(topicSave == "Enterprise & Education" ? Color.white : Color.secondary)
                                        
                                }
                                Spacer()
                            }
                            .padding(.leading,24)
                            .padding(.vertical,10)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(topicSave == "Enterprise & Education" ? Color.accentColor : Color.gray.opacity(0.1))
                                
                            )
                            .padding(.horizontal,10)
                            .padding(.top,-7.3)
                        }.buttonStyle(PlainButtonStyle())
                        Button(action:{
                            topicSave = "MFi Technologies"
                        }){
                            HStack{
                                VStack(alignment:.leading,spacing:1){
                                    Text("MFi Technologies")
                                        .foregroundStyle(topicSave == "MFi Technologies" ? Color.white : Color.primary)
                                    Text("MFi certification and tools")
                                        .font(.system(size: 10))
                                        .foregroundStyle(topicSave == "MFi Technologies" ? Color.white : Color.secondary)
                                       
                                }
                                Spacer()
                            }
                            .padding(.leading,24)
                            .padding(.vertical,10)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(topicSave == "MFi Technologies" ? Color.accentColor : (colorScheme == .dark ? Color.black.opacity(0.15) : Color.white))
                                
                            )
                            .padding(.horizontal,10)
                            .padding(.top,-7.3)
                            .padding(.bottom,12)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }.background(
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                        .fill(colorScheme == .dark ? Color.black.opacity(0.1) : Color.white)
                   
                )
            }.padding(.horizontal,70)
            
            
            Divider()
            HStack(alignment:.center){
                Button(action: {
                    helpSelectedPage = "Duplicate Feedback"
                    OpenHelpWindow.open()
                    
                    
                }) {
                    ZStack{
                        Image(systemName: "circle.fill")
                            .font(.system(size:20))
                            .foregroundStyle(colorScheme == .dark ? Color.gray.opacity(0.5) : Color.white)
                            .shadow(radius: 1)
                        Text("?")
                            .foregroundStyle(colorScheme == .dark ? Color.white : Color.black)
                            .font(.system(size:17))
                        
                    }
                    
                    
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.horizontal)
                
                
                
                
                Spacer()
                Button(action: {
                    showSheet = false
                }) {
                    Text("Close")
                        .padding(5) // Add padding around the text
                }
                
                
                
                
                
                Button(action: {
                    
                    showSheet = false
                    showSheet2 = true
                        
                    
                }) {
                    Text("Continue")
                        .padding(6.25) // Add padding around the text
                    
                }
                .buttonStyle(PlainButtonStyle())
                .background(Color.accentColor)
                .foregroundColor(Color.white)
                .cornerRadius(5)
                .padding([.trailing,])
                .shadow(radius:1)
               
              
                
                
                
            }
            .padding(.vertical)
            .padding(.top,-9.5)
        }.frame(width:1000)
    }
}



/*
#Preview {
    TopicSheetView(showSheet: .constant(true))
}
*/
