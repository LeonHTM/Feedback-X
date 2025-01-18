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

    var body: some View {
        
        Button(action:{
            OnlineCheck.checkGoogle{isOnline in
                if isOnline == true{
            text = "Online"}else{
                text = "Not Online"
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
