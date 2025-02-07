//
//  TestView.swift
//  Feedback X
//
//  Created by Leon  on 08.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import SwiftUI


struct TestView: View {
    
    @State var text: String = "MacBookAir10,1"
    @State var text2: String = "MacBookAir10,1"
    
    
    
    var body: some View {
        Menu {
            Button(action: {
                // Action for the first menu item
                print("Option 1 selected")
            }) {
                Label("Option 1", systemImage: "star")
            }
            
            Button(action: {
                // Action for the second menu item
                print("Option 2 selected")
            }) {
                Label("Option 2", systemImage: "heart")
            }
            
            Button(action: {
                // Action for the third menu item
                print("Option 3 selected")
            }) {
                Label("Option 3", systemImage: "gear")
            }
        } label: {
            Text("Tap me")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
}

#Preview {
    TestView()
}
