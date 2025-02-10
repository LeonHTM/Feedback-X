//
//  SettingsView.swift
//  Feedback X
//
//  Created by LeonHTM on 15.12.2024.
//  Copyright © 2024 LeonHTM. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    // State variables for managing alerts
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @AppStorage("accountsPath") var accountsPath: String = "/Users/leon/Desktop/Feedback-X/python/accounts/accounts.json"
    var accountURL: URL {
            URL(fileURLWithPath: accountsPath)
        }
    
    // Environment objects for account and file loaders
    @EnvironmentObject var accountLoader: AccountLoader
    @EnvironmentObject var fileLoader: FileLoader

    // AppStorage properties for storing user preferences
    @AppStorage("syncOpen") var syncOpen: Bool = false
    @AppStorage("AppLaunchCounter") var appLaunchCounter: Int = 1
    @AppStorage("HasShownAlert") var hasShownAlert: Bool = false
    @AppStorage("rotationAngle") var rotationAngle: Double = 0
    @AppStorage("DeveloperSettings") var developerSettings: Bool = false

    var body: some View {
        TabView {
            Tab("Main", systemImage: "gear") {
                Form {
                    // Synchronisation Section
                    /*
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Synchronisation")
                            .fontWeight(.bold)
                        Toggle(isOn: $syncOpen) {
                            Text("Sync to Open Feedback Repository")
                        }
                        .padding(.leading, 10)
                    }
                    */
                    
                    // Resets Section
                    VStack(alignment: .leading, spacing: 10) {
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
                        .padding(.leading, 10)
                        
                        Text("All Accounts will be deleted.")
                            .padding(.leading, 10)
                        
                        Button(action: {
                            // Configure alert details for "Reset Feedbacks"
                            alertTitle = "Reset Feedbacks"
                            alertMessage = "Are you sure you want to delete all sent feedbacks? This cannot be undone."
                            showAlert = true
                        }) {
                            Text("Reset Feedbacks")
                        }
                        .padding(.leading, 10)
                        
                        Text("All sent Feedbacks will be deleted from the App. (Only from the App).")
                            .padding(.leading, 10)
                    }
                    
                    // Developer Details Section
                    VStack(alignment: .leading) {
                        Text("Developer Details")
                            .fontWeight(.bold)
                            .offset(x: -5)
                        Toggle(isOn: $developerSettings) {
                            Text("Show Developer Details")
                        }
                        .padding(.horizontal, 5)
                        Spacer()
                    }
                    .padding(10)
                    
                    Spacer()
                }
                .padding(10)
                // Attach the alert to the form
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text(alertTitle),
                        message: Text(alertMessage),
                        primaryButton: .destructive(Text("Confirm")) {
                            if alertTitle == "Reset Warnings" {
                                appLaunchCounter = 0
                                hasShownAlert = false
                                rotationAngle = 0
                            }
                            if alertTitle == "Reset Accounts" {
                                accountLoader.loadAccounts(from: accountURL)
                                accountLoader.deleteAll(from: accountURL)
                            }
                            if alertTitle == "Reset Feedbacks" {
                                fileLoader.deleteAllFiles()
                            }
                            // Handle confirmation action
                            print("\(alertTitle) confirmed.")
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
