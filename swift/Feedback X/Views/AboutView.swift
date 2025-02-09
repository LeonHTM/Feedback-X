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
                }.buttonStyle(PlainButtonStyle())
                (
                    Text("Version: ") +
                    Text(VersionBuild.getAppVersion()) +
                    Text(" (") +
                    Text(VersionBuild.getBuildNumber()) +
                    Text(")")
                    
                    
                )
                .foregroundColor(.secondary)
                .font(.system(size: 12))
                Text("This App was made by LeonHTM")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                
                
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("Open Source")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    HStack{
                        Text("This project is open source and fully accessible on its GitHub repository. As this is my first project, the code may not be fully optimized. Contributions are welcome — feel free to submit a pull request to help improve the project.")
                        Spacer()
                    }
                        .padding(10)
                        .background(
                                RoundedRectangle(cornerRadius: 7)
                                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                    .fill(Color.gray.opacity(0.1))
                            )
                    
                   
                    
                    // Centering the GitHub link
                    HStack {
                        Spacer()
                        Link("View Project on GitHub",
                             destination: URL(string: "https://github.com/LeonHTM/Feedback-X")!)
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding(10)
                            .background(
                                    RoundedRectangle(cornerRadius: 7)
                                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                        .fill(Color.gray.opacity(0.1))
                                )
                        Spacer()
                    }
                    
                    Text("Libraries")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    // Full-width Libraries frame
                    Text("I have used the following Libraries to make this Project possible: \n - SwiftUI \n - Selenium \n - Undetected-chromedriver \n - Fake-useragent")
                        .padding(10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                                RoundedRectangle(cornerRadius: 7)
                                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                    .fill(Color.gray.opacity(0.1))
                            )
                    
                    Text("Report an Issue")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Text("Please check the User Guide before submitting an Issue.")
                        .padding(10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                                RoundedRectangle(cornerRadius: 7)
                                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                    .fill(Color.gray.opacity(0.1))
                            )
                
                    HStack {
                        Spacer()
                        Link("Report an Issue",
                             destination: URL(string: "https://github.com/LeonHTM/Feedback-X/issues/new?template=Blank+issue")!)
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding(10)
                            .background(
                                    RoundedRectangle(cornerRadius: 7)
                                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                        .fill(Color.gray.opacity(0.1))
                                )
                        Spacer()
                    }
                    
                    
                    
                    
                    Text("Privacy")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    HStack{
                        Text("Feedback X doesn't collect any personal data of any sort. In fact the Application doesn't collect any data at all. (Partly becuase I have no idea to set stuff like this up).")
                        Spacer()
                    }
                        .padding(10)
                        .background(
                                RoundedRectangle(cornerRadius: 7)
                                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                    .fill(Color.gray.opacity(0.1))
                            )
                }
                .padding(.horizontal)
                
                // Legal section in a VStack
                VStack(alignment: .leading, spacing: 10) {
                    Text("Legal")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Text("""
                    This app is provided as is, without any guarantees or warranties. The developer does not accept any responsibility for any actions taken by users of this app. By using this app, you agree to use it at your own risk. You acknowledge and agree that you are solely responsible for any actions taken using this program. The developer and any associated parties are not liable for any consequences arising from the use of this program. Your use of the program indicates your acceptance of these terms.
                    """)
                    .font(.body)
          
                    .padding(10)
                    .background(
                            RoundedRectangle(cornerRadius: 7)
                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                .fill(Color.gray.opacity(0.1))
                           
                        )
                }
                .padding(.horizontal)
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

