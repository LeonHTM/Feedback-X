//
//  aboutView.swift
//  Feedback X
//
//  Created by LeonHTM on 14.12.2024.
//  Copyright © 2024 LeonHTM. All rights reserved.


import SwiftUI

struct AboutView: View {
    
    @State private var clickCount: Int = 0
    @AppStorage("rotationAngle") private var rotationAngle: Double = 0
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.openURL) var openURL
    @State private var selectedPage: String = "Privacy"
    @AppStorage("helpSelectedPage") var helpSelectedPage: String = "Welcome"
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Button(action: {
                    clickCount += 1
                    if clickCount == 10 {
                        rotationAngle += Double.random(in: -360...360)
                        clickCount = 0
                    }
                }) {
                    Image("FeedbackX_512")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100) // Reduced size
                        .clipShape(Circle())
                        .shadow(radius: 5)
                        .rotationEffect(.degrees(rotationAngle))
                        .animation(.easeInOut(duration: 1), value: rotationAngle)
                        .padding(.top,50)
                }.buttonStyle(PlainButtonStyle())
                Text("Feedback X ")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                (
                    Text("Version: ") +
                    Text(VersionBuild.getAppVersion()) +
                    Text(" (") +
                    Text(VersionBuild.getBuildNumber()) +
                    Text(")")
                    
                    
                )
                .foregroundColor(.secondary)
                .font(.system(size: 12))
                
                ZStack{
                    HStack(spacing:0){
                        Button(action:{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                selectedPage = "Privacy"
                            }
                            
                        }){
                            Text("Privacy")
                                .padding(.vertical, selectedPage == "Privacy" ?  3 : 2)
                                .padding(.horizontal,7)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .background(selectedPage == "Privacy" ? Color.accentColor : Color.secondary)
                        .clipShape(
                            .rect(
                                topLeadingRadius: 5,
                                bottomLeadingRadius: 5,
                                bottomTrailingRadius: 0,
                                topTrailingRadius: 0
                            )
                        )
                        .foregroundColor(.white)
                        .shadow(radius:3)
                        .contentShape(Rectangle())
                        
                        Divider()
                        Button(action:{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                selectedPage = "Open Source"
                            }
                            
                            
                        }){
                            Text("Open Source")
                                .padding(.vertical, selectedPage == "Open Source" ?  3 : 2)
                                .padding(.horizontal,7)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .background(selectedPage == "Open Source" ? Color.accentColor : Color.secondary)
                        .foregroundColor(Color.white)
                        /*.clipShape(selectedPage == "Open Source" ? RoundedRectangle(cornerRadius: 4) : RoundedRectangle(cornerRadius: 0) )*/
                        .shadow(radius:3)
                        .contentShape(Rectangle())
                        
                        
                        Divider()
                        Button(action:{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                selectedPage = "Legal"
                            }
                        }){
                            Text("Legal ")
                                .padding(.vertical, selectedPage == "Legal" ?  3 : 2)
                                .padding(.horizontal,7)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .background(selectedPage == "Legal" ? Color.accentColor : Color.secondary)
                        .clipShape(
                            .rect(
                                topLeadingRadius: 0,
                                bottomLeadingRadius: 0,
                                bottomTrailingRadius: 5,
                                topTrailingRadius: 5
                            )
                        )
                        .foregroundColor(.white)
                        .shadow(radius:3)
                        .contentShape(Rectangle())
                        
                        
                        
                        
                    }
                }
             
                VStack(alignment:.leading){
                    if selectedPage == "Open Source"{
                        HStack{
                            VStack(alignment:.leading,spacing:10){
                                Text("Open Source")
                                    .fontWeight(.bold)
                                    .font(.system(size:15))
                                
                                Text("This project is open source and fully accessible on its GitHub repository. As this is my first project, the code may not be fully optimized. Contributions are welcome — feel free to submit a pull request to help improve the project.").padding(.top,-5)
                                Button(action:{
                                    
                                    
                                    if let url = URL(string: "https://github.com/LeonHTM/Feedback-X/") {
                                        openURL(url)
                                    }
                                }){
                                    
                                    Text("Open Github Repositry")
                                }
                                
                                Text("Report an Issue")
                                    .fontWeight(.bold)
                                    .font(.system(size:15))
                                    .padding(.top,5)
                                
                                Text("If you encounter an Issue, report it. You can also report a Suggestion for the App. Please check the user guide before submitting an Issue.").padding(.top,-5)
                                Button(action:{
                                    helpSelectedPage = "Welcome"
                                    OpenHelpWindow.open()
                                    
                                    
                                }){
                                    
                                    Text("Open the User Guide")
                                }
                                Button(action:{
                                    
                                    
                                    if let url = URL(string: "https://github.com/LeonHTM/Feedback-X/issues/new?template=Blank+issue") {
                                        openURL(url)
                                    }
                                }){
                                    
                                    Text("Report an Issue")
                                }
                                Spacer()
                                
                            }.padding([.leading,.top,.trailing],30)
                            Spacer()
                        }
                        
                        
                    
                        
                        
                        
                        
                    }else if selectedPage == "Legal"{
                        HStack{
                            VStack(alignment:.leading,spacing:10){
                                Text("Legal")
                                    .fontWeight(.bold)
                                    .font(.system(size:15))
                                
                                Text("This app is provided as is, without any guarantees or warranties. The developer does not accept any responsibility for any actions taken by users of this app. By using this app, you agree to use it at your own risk. You acknowledge and agree that you are solely responsible for any actions taken using this program. The developer and any associated parties are not liable for any consequences arising from the use of this program. Your use of the program indicates your acceptance of these terms.").padding(.top,-5)
                                Spacer()
                                
                            }.padding([.leading,.top,.trailing],30)
                            Spacer()
                        }
                        
                        
                        
                        
                    }else{
                        HStack{
                            VStack(alignment:.leading,spacing:10){
                                Text("Privacy")
                                    .fontWeight(.bold)
                                    .font(.system(size:15))
                                
                                Text("Feedback X doesn't collect any data at all.").padding(.top,-5)
                                Spacer()
                                
                            }.padding([.leading,.top,],30)
                            Spacer()
                        }
                        
                        
                        
                    }
                 
                  
                }
                .frame(height:500)
                .background(
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                        .fill(Color.gray.opacity(0.1))
                )
                
                    
                
                    
                
                
                
                HStack(spacing:7){
                    Text("This Application was made by LeonHTM").foregroundStyle(.secondary)
                    Button(action: {
                                if let url = URL(string: "https://github.com/LeonHTM") {
                                    openURL(url)
                                }
                            }) {
                                Image("github")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundStyle(Color.secondary)
                            }
                            .buttonStyle(PlainButtonStyle())
                    
                }
                
            }
            .padding([.leading,.trailing,.bottom],20)
            
        }.if(colorScheme == .light){
            $0.background(Color.white)
        }
    }
}

#Preview {
    AboutView()
}

