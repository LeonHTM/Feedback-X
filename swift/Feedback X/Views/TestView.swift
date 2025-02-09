//
//  TestView.swift
//  Feedback X
//
//  Created by Leon  on 08.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import SwiftUI


struct TestView: View {
    
    
    var body: some View {
      
        Text(VersionBuild.getAppVersion())
        Text(String(VersionBuild.getBuildNumber()))
        
        Button(action:{}){
            
            Text("yo")
        }.buttonStyle(LinkButtonStyle())
    }
}

#Preview {
    TestView()
}
