//
//  CookiesViewSheet.swift
//  Feedback X
//
//  Created by Leon  on 05.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import SwiftUI
import Foundation

struct CookiesSheetView: View {
    
    // Path to the accounts.json file
    @AppStorage("accountsPath") var accountsPath: String = ""
    var accountURL: URL {
        URL(fileURLWithPath: accountsPath)
    }
    
    // AppStorage for selected help page
    @AppStorage("helpSelectedPage") var helpSelectedPage: String = "Set up Cookies"
    @AppStorage("cookiesFolderPath") var cookiesFolderPath: String = ""
    
    
    // Environments
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var accountLoader: AccountLoader
    @EnvironmentObject var cookiesPython: CookiesPython
    
    // State variables
    @State private var showAlert = false
    @State private var isSubmitEnabled = false
    @State private var showCloseAlert = false
    @State private var showDuplicateAlert = false
    @State public var selectedHelpPage:String = "Set up Cookies"
    @State private var step: Double = 0
    @State private var buttonAllowed: Bool = true
    @State private var goneWrong: Bool = false
    @State private var currentStep: Int = 0
    @State private var totalSteps: Int = 0
    @State var dateSave = Calendar.current.date(byAdding: .day, value: 30, to: Date())?
        .formatted(Date.FormatStyle()
            .day(.defaultDigits)
            .month(.defaultDigits)
            .year())
    
    // Binding variables
    @Binding var showSheet: Bool
    @Binding var selectedList: [Int]
    @Binding var waitingTime: Int
    
    // AppStorage for developer settings
    @AppStorage("DeveloperSettings") var developerSettings: Bool = false
    
    // Computed property for progress
    var progress: Double {
        Double(currentStep) / Double(totalSteps)
    }
    
    func cookies(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            buttonAllowed = true
            
            if currentStep - 1 < selectedList.count && !goneWrong {
                if accountLoader.accounts[selectedList[currentStep - 1]].cookies == "y" {
                    dateSave = accountLoader.accounts[selectedList[currentStep - 1]].date
                }
                
                let updatedAccount = Account(
                    account: accountLoader.accounts[selectedList[currentStep - 1]].account,
                    icloudmail: accountLoader.accounts[selectedList[currentStep - 1]].icloudmail,
                    password: accountLoader.accounts[selectedList[currentStep - 1]].password,
                    relay: accountLoader.accounts[selectedList[currentStep - 1]].relay,
                    country: accountLoader.accounts[selectedList[currentStep - 1]].country,
                    appledev: accountLoader.accounts[selectedList[currentStep - 1]].appledev,
                    cookies: "y",
                    note: accountLoader.accounts[selectedList[currentStep - 1]].note,
                    date: dateSave ?? "Unknown"
                )
                accountLoader.editAccount(at: selectedList[currentStep - 1], with: updatedAccount, to: accountURL)
                dateSave = Calendar.current.date(byAdding: .day, value: 30, to: Date())?
                    .formatted(Date.FormatStyle()
                        .day(.defaultDigits)
                        .month(.defaultDigits)
                        .year())
            } else {
                print("Couldnt edit Account")
            }
        }
        if currentStep < totalSteps {
            currentStep += 1
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 15) {
                // Display current step or completion status
                if currentStep < totalSteps {
                    Text("Account \(currentStep + 1) of \(totalSteps)")
                        .font(.title)
                        .fontWeight(.bold)
                } else if goneWrong {
                    Text("Something has gone wrong")
                        .font(.title)
                        .fontWeight(.bold)
                } else {
                    Text("All done")
                        .font(.title)
                        .fontWeight(.bold)
                }
                
                // Display current account or error message
                if !goneWrong && currentStep < totalSteps {
                    Text("Current Account:")
                    if !accountLoader.accounts.isEmpty {
                        Text(" \(accountLoader.accounts[selectedList[currentStep]].icloudmail)")
                            .font(.title3)
                            .fontWeight(.bold)
                    } else {
                        Text("Error")
                    }
                } else if goneWrong {
                    Text("Please try again or go to the next account.")
                    Text("Note: If on the first try, something instantly goes wrong, please quit all Google Chrome sessions and try again.")
                        .foregroundStyle(.secondary)
                        .font(.system(size: 12))
                }
                
                // Progress view
                ProgressView(value: progress)
                    .padding()
                // Progress view for button action
                if !buttonAllowed {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                        .scaleEffect(1.0, anchor: .center)
                        .padding(.bottom)
                }
                


                // Button to enable cookies
                Button(action: {
                    buttonAllowed = false
                    goneWrong = false
                    
                    cookiesPython.run(
                        startValue: selectedList[currentStep] + 1,
                        iterationValue: selectedList[currentStep] + 1,
                        chillValue: waitingTime,
                        headlessValue: "False",
                        accounts_file_path: accountsPath,
                        cookies_file_path: cookiesFolderPath
                    ) { success, output, error in
                        if success {
                            cookies()
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                buttonAllowed = true
                            }
                            goneWrong = true
                        }
                        
                        if let output = output, output.contains("Failed") {
                            goneWrong = true
                        }
                    }
                }) {
                    if currentStep < totalSteps {
                        if !accountLoader.accounts.isEmpty {
                            Text("Enable Cookies for \(accountLoader.accounts[selectedList[currentStep]].icloudmail)")
                        } else {
                            Text("Error")
                        }
                    } else {
                        Text("Done")
                    }
                }
                .disabled(currentStep >= totalSteps || !buttonAllowed)
                
                // Try again button
                Button(action: {
                    if currentStep > 0 {
                        currentStep -= 1
                    }
                    buttonAllowed.toggle()
                    goneWrong = false
                    
                    cookiesPython.run(
                        startValue: selectedList[currentStep] + 1,
                        iterationValue: selectedList[currentStep] + 1,
                        chillValue: waitingTime,
                        headlessValue: "False",
                        accounts_file_path: accountsPath,
                        cookies_file_path: cookiesFolderPath
                    ) { success, output, error in
                        if success {
                            cookies()
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                buttonAllowed = true
                            }
                            goneWrong = true
                        }
                        
                        if let output = output, output.contains("Failed") {
                            goneWrong = true
                        }
                    }
                }) {
                    Text("Try Again")
                }
                .disabled(currentStep <= 0 || !buttonAllowed)
                
                Spacer()
            }
            .padding()
            .onAppear {
                accountLoader.loadAccounts(from: accountURL)
                selectedList.sort()
                totalSteps = selectedList.count
            }
        }
        .padding(.bottom, -9.5)
        
        Divider()
        HStack {
            // Help button
            Button(action: {
                helpSelectedPage = "Set up Cookies"
                OpenHelpWindow.open()
            }) {
                ZStack {
                    Image(systemName: "circle.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(colorScheme == .dark ? Color.gray.opacity(0.5) : Color.white)
                        .shadow(radius: 1)
                    Text("?")
                        .foregroundStyle(colorScheme == .dark ? Color.white : Color.black)
                        .font(.system(size: 17))
                }
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.top, 1)
            .padding([.leading, .trailing, .bottom], 10)
            
            Spacer()
            
            // Developer settings text
            if developerSettings {
                Text("Details: WaitingTime: \(waitingTime) Division: \(currentStep)/\(totalSteps) ButtonAllowed: \(buttonAllowed) goneWrong: \(goneWrong), dateSave: \(dateSave ?? "Unknown")")
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            // Close button
            Button(action: {
                showSheet = false
            }) {
                Text("Close")
                    .padding(5)
            }
            .cornerRadius(5)
            .padding(.top, 1)
            .padding([.leading, .trailing, .bottom], 10)
        }
        .frame(width: 1000)
    }
}

#Preview {
    @Previewable @StateObject var accountLoader = AccountLoader()
    @Previewable @State var list: [Int] = [0, 1, 8, 9]
    @Previewable @State var waitingTime = 10
    CookiesSheetView(showSheet: .constant(true), selectedList: $list, waitingTime: $waitingTime)
        .environmentObject(accountLoader)
}
