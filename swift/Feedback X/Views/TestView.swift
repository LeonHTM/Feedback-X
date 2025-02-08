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
    
    @State private var sliderSave: Double = 4
    @State private var accountNumber: Double = 100
    
    var body: some View {
        Menu {
            Button(action: {
                // Action for the first menu item
                sliderSave = 200
            }) {
                Label("Option 1", systemImage: "star")
            }
      
        } label: {
            Text("Tap me")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        Text(VersionBuild.getAppVersion())
        Text(String(VersionBuild.getBuildNumber()))
        
    }
}

#Preview {
    TestView()
}
