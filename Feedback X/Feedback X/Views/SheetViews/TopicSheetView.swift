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
  
    @State private var showAlert: Bool = false
    
    // Check if the selected topic is allowed
    private var topicAllowed: Bool {
        return topicSave == "iOS & iPadOS"
    }
    
    var body: some View {
        VStack(alignment:.leading){
            VStack(alignment:.leading){
                Text("What are you seeing an Issue with?")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top,50)
                    .padding(.bottom,-5)
                
                ScrollView {
                    VStack(alignment: .leading) {
                        // Button for iOS & iPadOS
                        Button(action: {
                            topicSave = "iOS & iPadOS"
                        }) {
                            HStack {
                                VStack(alignment:.leading) {
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
                     
                        // Button for macOS
                        Button(action: {
                            topicSave = "macOS"
                        }) {
                            HStack {
                                VStack(alignment:.leading,spacing:1) {
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
                        
                        // Button for tvOS
                        Button(action: {
                            topicSave = "tvOS"
                        }) {
                            HStack {
                                VStack(alignment:.leading,spacing:1) {
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
                        
                        // Button for visionOS
                        Button(action: {
                            topicSave = "visionOS"
                        }) {
                            HStack {
                                VStack(alignment:.leading,spacing:1) {
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
                        
                        // Button for watchOS
                        Button(action: {
                            topicSave = "watchOS"
                        }) {
                            HStack {
                                VStack(alignment:.leading,spacing:1) {
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
                        
                        // Button for HomePod
                        Button(action: {
                            topicSave = "HomePod"
                        }) {
                            HStack {
                                VStack(alignment:.leading,spacing:1) {
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
                        
                        // Button for AirPods Beta Firmware
                        Button(action: {
                            topicSave = "AirPods Beta Firmware"
                        }) {
                            HStack {
                                VStack(alignment:.leading,spacing:1) {
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
                        
                        // Button for Developer Technologies & SDKs
                        Button(action: {
                            topicSave = "Developer Technologies & SDKs"
                        }) {
                            HStack {
                                VStack(alignment:.leading,spacing:1) {
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
                        
                        // Button for Developer Tools & Resources
                        Button(action: {
                            topicSave = "Developer Tools & Resources"
                        }) {
                            HStack {
                                VStack(alignment:.leading,spacing:1) {
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
                        
                        // Button for Enterprise & Education
                        Button(action: {
                            topicSave = "Enterprise & Education"
                        }) {
                            HStack {
                                VStack(alignment:.leading,spacing:1) {
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
                        
                        // Button for MFi Technologies
                        Button(action: {
                            topicSave = "MFi Technologies"
                        }) {
                            HStack {
                                VStack(alignment:.leading,spacing:1) {
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
                }
                .background(
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                        .fill(colorScheme == .dark ? Color.black.opacity(0.1) : Color.white)
                )
            }
            .padding(.horizontal,70)
            
            Divider()
            
            HStack(alignment:.center) {
                // Help button
                Button(action: {
                    helpSelectedPage = "Duplicate Feedback"
                    OpenHelpWindow.open()
                }) {
                    ZStack {
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
                
                // Close button
                Button(action: {
                    showSheet = false
                }) {
                    Text("Close")
                        .padding(5) // Add padding around the text
                }
                
                // Continue button
                Button(action: {
                    if topicAllowed {
                        showSheet = false
                        showSheet2 = true
                    } else {
                        showAlert = true
                    }
                }) {
                    Text("Continue")
                        .padding(6.25) // Add padding around the text
                }
                .buttonStyle(PlainButtonStyle())
                .background(Color.accentColor)
                .foregroundColor(Color.white)
                .cornerRadius(5)
                .padding([.trailing])
                .shadow(radius:1)
                .alert("Topic not available", isPresented: $showAlert) {
                    Button("OK", role: .cancel) {}
                } message: {
                    Text("Please select another topic. \(topicSave) has not been implemented yet. Currently available topics are: \n iOS & iPadOS")
                }
            }
            .padding(.vertical)
            .padding(.top,-9.5)
        }
        .frame(width:1000)
    }
}

/*
#Preview {
    TopicSheetView(showSheet: .constant(true))
}
*/
