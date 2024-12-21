//
//  SettingsView.swift
//  Feedback X
//
//  Created by LeonHTM on 15.12.2024.
//  Copyright © 2024 LeonHTM. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @State var SyncOpen: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @AppStorage("AppLaunchCounter") var appLaunchCounter: Int = 1
    @AppStorage("HasShownAlert") var hasShownAlert: Bool = false

    var body: some View {
        TabView{
            Tab("Main", systemImage: "gear") {
                Form {
                    // Synchronisation Section
                    VStack(alignment: .leading) {
                        Text("Synchronisation")
                            .fontWeight(.bold)
                        Toggle(isOn: $SyncOpen) {
                            Text("Sync to Open Feedback Repository")
                        }
                        .padding(.vertical, 5)
                        .padding(.leading, 10)
                    }
                    .padding(.horizontal, 10)
                    
                    // Resets Section
                    VStack(alignment: .leading) {
                        Text("Resets")
                            .fontWeight(.bold)
                        
                        Button(action: {
                            // Configure alert details for "Reset Warnings"
                            alertTitle = "Reset Warnings"
                            alertMessage = "Are you sure you want to reset all warnings? This action cannot be undone."
                            showAlert = true
                        }) {
                            Text("Reset Warnings")
                        }
                        .padding(.vertical, 5)
                        .padding(.leading, 10)
                        
                        Text("This will show all Warnings again")
                            .padding(.leading, 10)
                        
                        Button(action: {
                            // Configure alert details for "Reset Accounts"
                            alertTitle = "Reset Accounts"
                            alertMessage = "Are you sure you want to reset all accounts? All saved accounts will be removed."
                            showAlert = true
                        }) {
                            Text("Reset Accounts")
                        }
                        .padding(.vertical, 5)
                        .padding(.leading, 10)
                        
                        Text("All Accounts will be reset. The App will have no Accounts saved.")
                            .padding(.leading, 10)
                        
                        Button(action: {
                            // Configure alert details for "Reset Feedbacks"
                            alertTitle = "Reset Feedbacks"
                            alertMessage = "Are you sure you want to forget all sent feedbacks? This cannot be undone."
                            showAlert = true
                        }) {
                            Text("Reset Feedbacks")
                        }
                        .padding(.vertical, 5)
                        .padding(.leading, 10)
                        
                        Text("The App will forget all Feedbacks sent")
                            .padding(.leading, 10)
                    }
                    .padding(.horizontal, 10)
                }
                .padding(10)
                // Attach the alert to the form
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text(alertTitle),
                        message: Text(alertMessage),
                        primaryButton: .destructive(Text("Confirm")) {
                            if alertTitle == "Reset Warnings"{
                                
                                appLaunchCounter = 0
                                hasShownAlert = false
                            }
                            // Handle confirmation action here
                            print("\(alertTitle) confirmed.")
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
        }.navigationTitle("Feedback X Settings")
    }
}

#Preview {
    SettingsView()
}
