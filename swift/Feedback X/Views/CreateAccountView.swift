//
//  CreateAccountView.swift
//  Feedback X
//
//  Created by Leon  on 25.12.2024.
//  Copyright © 2024 LeonHTM. All rights reserved.
//

import SwiftUI

struct CreateAccountView: View {
    
    @AppStorage("HasShownAlert") var hasShownAlert: Bool = false
    @AppStorage("AppLaunchCounter") var appLaunchCounter: Int = 1
    @State private var showAlert: Bool = false
    @State public var showAccountSheet = false
    
    
    
    var body: some View {
        VStack {
            Text("No Account Selected")
                .font(.title2)
                .foregroundStyle(Color.secondary)
                .onAppear {
                    // Trigger alert only if appLaunchCounter is 1 and it hasn't been shown yet
                    if appLaunchCounter == 1 && !hasShownAlert {
                        showAlert = true
                        hasShownAlert = true // Ensure the alert is only shown once
                    }
                }
            
            Button(action: {
                showAccountSheet = true
            }) {
                Text(isRunning ? "Adding New Account" : "Add Account")
                    .padding(1)
            }
        }
    }
    
}
#Preview{
    CreateAccountView()
}
