//
//  aboutView.swift
//  Feedback X
//
//  Created by LeonHTM on 14.12.2024.
//  Copyright © 2024 LeonHTM. All rights reserved.


import SwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Image("FeedbackX256.png")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100) // Reduced size
                    .clipShape(Circle())
                    .shadow(radius: 5)
                
                Text("This App was made by LeonHTM")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("Open Source")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Text("This project is open source and fully accessible on its GitHub repository. As this is my first project, the code may not be fully optimized. Contributions are welcome — feel free to submit a pull request to help improve the project.")
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
                }
                .padding(.horizontal)
                
                // Legal section in a VStack
                VStack(alignment: .leading, spacing: 10) {
                    Text("Legal")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Text("""
                    This app is provided as is, without any guarantees or warranties. The developer does not accept any responsibility for any actions taken by users of this app. By using this app, you agree to use it at your own risk. By clicking 'Accept', you acknowledge and agree that you are solely responsible for any actions taken using this program. The developer and any associated parties are not liable for any consequences arising from the use of this program. Your use of the program indicates your acceptance of these terms.
                    """)
                    .font(.body)
                    .lineSpacing(5)
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
            
        }
    }
}

#Preview {
    AboutView()
}

