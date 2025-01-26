//
//  TestView.swift
//  Feedback X
//
//  Created by Leon  on 08.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import SwiftUI

struct TestView: View {
    @State private var cookiesList: Set<String> = []

    var items = ["yo", "wallah yo", "antifa"]
    @State var text:String = ""
    @State private var accountURL = URL(fileURLWithPath: "/Users/leon/Desktop/Feedback-X/python/accounts/accounts.json")

    var body: some View {
        VStack(alignment:.leading){
            Button(action:{
                CookiesCheck.check(iterations:3, accountURL: accountURL ){isOnline in
                    if isOnline == true{
                        text = "Cookies Good"}else{
                            text = "Cookies Bad"
                        }
                    
                    
                }
            })
            {Text("Online Check")}
                .padding(10)
            Text(text)
            
            
            Divider()
            HStack(alignment:.center){
                Button(action: {
                    OpenHelpWindow.open(selectedPage: "Create Account")
                    
                    
                }) {
                    Image(systemName: "questionmark.circle.fill")
                        .font(.system(.title2))
                        .foregroundColor(.gray)
                    
                    
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.horizontal)
                
                
                
                
                Spacer()
                Button(action: {
                   
                }) {
                    Text("Close")
                        .padding(5) // Add padding around the text
                }
                
                
                
                
                
                Button(action: {
                    
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
        }.frame(width:500)
        
        
    }
    
}

#Preview {
    TestView()
}
