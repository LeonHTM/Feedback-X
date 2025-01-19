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
    @State private var showAccountAlert: Bool = false
    @AppStorage("HasShownAlert") var hasShownAlert: Bool = false
    @AppStorage("AppLaunchCounter") var appLaunchCounter: Int = 1
    @EnvironmentObject var accountLoader: AccountLoader
    @EnvironmentObject var feedbackPython: FeedbackPython
    let accountURL = URL(fileURLWithPath: "/Users/leon/Desktop/Feedback-X/python/accounts/accounts.json")

    var body: some View {
        VStack {
            Text("No Feedback Selected")
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
                accountLoader.loadAccounts(from: accountURL)
                if accountLoader.accounts.count >= 2{
                    showSheet = true
                }else{
                    showAccountAlert = true
                }
            }) {
                Text(isRunning ? "Creating New Feedback" : "New Feedback")
                    .padding(1)
            }
            .disabled(isRunning)
            .padding(5)
            .alert("Not enough Accounts", isPresented: $showAccountAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                if accountLoader.accounts.count == 0 {
                    Text("You need to have at least 2 accounts to create feedback. You currently only have \(accountLoader.accounts.count) accounts.")}else{
                        
                        Text("You need to have at least 2 accounts to create feedback. You currently only have \(accountLoader.accounts.count) account.")
                    }
            }
            .sheet(isPresented: $showSheet, onDismiss: { feedbackPython.stop() }) {
                CreateFeedbackSheetView(showSheet : $showSheet)
                    .environmentObject(accountLoader)
                    .environmentObject(feedbackPython)
            }
        }
        .frame(minWidth: 500,maxWidth:700)
        .frame(maxHeight: .infinity)
        .alert("Legal Notice", isPresented: $showAlert) {
            Button("Quit Feedback X", role: .cancel) {
                showAlert = false
                appLaunchCounter = 0
                hasShownAlert = false
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


