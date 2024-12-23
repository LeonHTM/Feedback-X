//
//  CreateFeedbackView.swift
//  Feedback X
//
//  Created by LeonHTM on 11.12.2024.
//  Copyright © 2024 LeonHTM. All rights reserved.


import SwiftUI

struct CreateFeedbackView: View {
    @State private var isRunning = false
    @State private var showAlert = false
    @State public var showSheet = false
    @State private var feedbackTitle: String = ""
    @State private var selectedOption = "Option 1"
    @AppStorage("HasShownAlert") var hasShownAlert: Bool = false
    @AppStorage("AppLaunchCounter") var appLaunchCounter: Int = 1

    var body: some View {
        VStack {
            Text("No recent feedback selected")
                .font(.headline)
                .fontWeight(.bold)
                .onAppear {
                    // Trigger alert only if appLaunchCounter is 1 and it hasn't been shown yet
                    if appLaunchCounter == 1 && !hasShownAlert {
                        showAlert = true
                        hasShownAlert = true // Ensure the alert is only shown once
                    }
                }

            Button(action: {
                showSheet = true
            }) {
                Text(isRunning ? "Creating New Feedback" : "New Feedback")
                    .padding(1)
            }
            .disabled(isRunning)
            .padding(5)
            .sheet(isPresented: $showSheet) {
                CreateFeedbackSheetView(showSheet : $showSheet)
                    
            }
        }
        .frame(minWidth: 500,maxWidth:700)
        .frame(maxHeight: .infinity)
        .alert("Legal Notice", isPresented: $showAlert) {
            Button("Quit Feedback X", role: .cancel) {
                showAlert = false
                appLaunchCounter = 0 // Reset counter or handle quitting
                exit(0)
            }
            Button("Accept") {}
        } message: {
            Text("By clicking 'Accept', you acknowledge and agree that you are solely responsible for any actions taken using this program. The developer and any associated parties are not liable for any consequences arising from the use of this program. Your use of the program indicates your acceptance of these terms.")
        }
    }
}

#Preview {
    CreateFeedbackView()
}


