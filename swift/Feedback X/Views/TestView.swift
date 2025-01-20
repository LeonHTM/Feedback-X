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
           
            
        
    }
    
}

#Preview {
    TestView()
}
