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
        VStack {
            Text(VersionBuild.getAppVersion())
            Text(String(VersionBuild.getBuildNumber()))
            
            Button(action: {
                print("yo") // When button is clicked
            }) {
                Text("yo")
            }
            .buttonStyle(LinkButtonStyle())
        }
        .onAppear {
            NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
                if event.keyCode == 36 { // 36 = Return key
                    print("yo") // Print "yo" when Enter is pressed
                    return nil // Stop further event propagation
                }
                return event
            }
        }
    }
}

#Preview {
    TestView()
}

