//
//  CookiesView.swift
//  Feedback X
//
//  Created by Leon  on 04.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import SwiftUI

struct CookiesView: View {
    
    // Environment objects for account and cookies management
    @EnvironmentObject var accountLoader: AccountLoader
    @EnvironmentObject var cookiesPython: CookiesPython

    // Environment variable for the color scheme (light or dark mode)
    @Environment(\.colorScheme) var colorScheme

    // State variables for managing UI and user interactions
    @AppStorage("accountsPath") var accountsPath: String = "/Users/leon/Desktop/Feedback-X/python/accounts/accounts.json"
    var accountURL: URL {
            URL(fileURLWithPath: accountsPath)
        }
    @State private var isEditing: Bool = false
    @State private var waitingTime = 30.0
    @State private var waitingTimeInt = 30
    @State private var extraWaiting: Bool = false
    @State private var maxSlider: Double = 60
    @State private var stepSlider: Double = 1
    @State private var buttonActive: Bool = false
    @AppStorage("CookiesshowSheet") var showSheet: Bool = false
    @State private var cookiesList: [Int] = []

    // Computed property to check if the button should be enabled
    private var isButtonAllowed: Bool {
        return !cookiesList.isEmpty
    }

    // AppStorage property for storing developer settings
    @AppStorage("DeveloperSettings") var developerSettings: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollView {
                if !accountLoader.accounts.isEmpty {
                    VStack(alignment: .leading, spacing: 15) {
                        // Basic Information Section
                        Text("Basic Information")
                            .font(.title3)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 5)
                            .padding(.top, 15)
                        
                        // Account Selection Section
                        VStack(alignment: .leading) {
                            Text("Select accounts you want to save cookies for")
                                .font(.title3)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Divider()
                            ForEach(accountLoader.accounts.indices, id: \.self) { index in
                                let account = accountLoader.accounts[index]
                                if index <= 9 {
                                    ZStack {
                                        if index == accountLoader.accounts.count - 1 || index == 9 {
                                            RoundedRectangle(cornerRadius: 0)
                                                .fill(account.appledev != "y" ? Color.red.opacity(0.2) : (cookiesList.contains(index) ? Color.gray.opacity(0.2) : Color.clear))
                                                .clipShape(
                                                    .rect(
                                                        topLeadingRadius: 0,
                                                        bottomLeadingRadius: 14,
                                                        bottomTrailingRadius: 14,
                                                        topTrailingRadius: 0
                                                    )
                                                )
                                                .padding(.top, -5)
                                                .padding(.bottom, -4)
                                                .padding(.horizontal, -15)
                                        } else {
                                            RoundedRectangle(cornerRadius: 0)
                                                .fill(account.appledev != "y" ? Color.red.opacity(0.2) : (cookiesList.contains(index) ? Color.gray.opacity(0.2) : Color.clear))
                                                .padding(.top, -5)
                                                .padding(.horizontal, -15)
                                        }
                                        
                                        VStack {
                                            HStack {
                                                ZStack {
                                                    Image(systemName: "circle")
                                                        .font(.system(size: 20))
                                                    Image(systemName: cookiesList.contains(index) ? "checkmark" : "")
                                                        .foregroundStyle(Color.white)
                                                }
                                                .background(
                                                    Circle()
                                                        .fill(cookiesList.contains(index) ? Color.accentColor : Color.clear)
                                                )
                                                .foregroundStyle(cookiesList.contains(index) ? Color.accentColor : Color.primary)
                                                
                                                VStack(alignment: .leading) {
                                                    Text(account.icloudmail)
                                                        .padding(.horizontal)
                                                        .fontWeight(.bold)
                                                    
                                                    if account.cookies == "y" {
                                                        Text("Cookies already set up: ✅")
                                                            .padding(.horizontal)
                                                            .padding(.vertical, 1)
                                                    } else {
                                                        Text("Cookies not set up: ❌")
                                                            .padding(.horizontal)
                                                            .padding(.vertical, 1)
                                                    }
                                                }
                                                
                                                Spacer()
                                                
                                                if account.appledev != "y" {
                                                    Image(systemName: "exclamationmark.circle.fill")
                                                        .foregroundStyle(Color.red)
                                                    Text("Set up Apple Developer first")
                                                }
                                            }
                                            .contentShape(Rectangle())
                                            .onTapGesture {
                                                if account.appledev == "y" {
                                                    if !cookiesList.contains(index) {
                                                        cookiesList.append(index)
                                                    } else {
                                                        cookiesList.removeAll { $0 == index }
                                                        print("remove from list")
                                                    }
                                                }
                                            }
                                            
                                            if index != accountLoader.accounts.count - 1 && index != 9 {
                                                Divider()
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding([.top, .leading, .trailing])
                        .padding(.bottom, 5)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                .fill(Color.gray.opacity(0.1))
                        )
                        
                        // Details Section
                        Text("Details")
                            .font(.title3)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 5)
                        
                        VStack(alignment: .leading) {
                            Text("Please select the waiting time")
                                .font(.title3)
                                .fontWeight(.bold)
                            Slider(
                                value: $waitingTime,
                                in: 20...maxSlider,
                                step: stepSlider
                            ) {
                                Text("Seconds")
                            } minimumValueLabel: {
                                Text("20")
                            } maximumValueLabel: {
                                Text("\(Int(maxSlider))")
                            } onEditingChanged: { editing in
                                isEditing = editing
                            }
                            HStack(spacing: 0) {
                                Text("You will have ")
                                Text("\(Int(waitingTime))")
                                    .foregroundStyle(isEditing ? ColorForWaitingTime.colorMatch(waitingTime, maxTime: maxSlider) : Color.primary)
                                Text(" seconds. In this time you will receive an SMS with a 6-digit code from Apple and you will have to enter it in the app.")
                            }
                            Toggle(isOn: $extraWaiting) {
                                Text("More time")
                            }.onChange(of: extraWaiting) {
                                if extraWaiting == true {
                                    maxSlider = 300
                                    stepSlider = 5
                                } else {
                                    maxSlider = 60
                                    stepSlider = 1
                                    if waitingTime > maxSlider {
                                        waitingTime = maxSlider
                                    }
                                }
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                .fill(Color.gray.opacity(0.1))
                        )
                        
                        // Running Section
                        Text("Running")
                            .font(.title3)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 5)
                        VStack {
                            Text("Please use the question mark at the bottom left if you are not sure what you are doing or if you don't understand why this step is necessary and how it is performed.")
                                .frame(maxWidth: .infinity)
                            
                            Button(action: {
                                showSheet.toggle()
                                waitingTimeInt = Int(waitingTime)
                            }) {
                                Text("Start")
                            }
                            .disabled(!isButtonAllowed)
                            .sheet(isPresented: $showSheet, onDismiss: { cookiesPython.stop() }) {
                                CookiesSheetView(showSheet: $showSheet, selectedList: $cookiesList, waitingTime: $waitingTimeInt)
                                    .environmentObject(accountLoader)
                                    .environmentObject(cookiesPython)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                .fill(Color.gray.opacity(0.1))
                        )
                    }
                    .padding(.bottom, 15)
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity)
                } else {
                    Text("No Accounts yet. Please add accounts before you set up cookies")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundStyle(Color.secondary)
                        .padding()
                }
            }
            .onAppear {
                // Load accounts when the view appears
                accountLoader.loadAccounts(from: accountURL)
            }
            
            HStack {
                Spacer()
                
                if developerSettings == true {
                    Text("DevDetails: List: \(cookiesList.map { String($0) }.joined(separator: ", ")), WaitingTime: \(String(waitingTimeInt))")
                        .foregroundStyle(Color.secondary)
                    Spacer()
                }
            }
        }
        .if(colorScheme == .light) {
            $0.background(Color.white)
        }
        .frame(minWidth: 1000)
        .frame(maxWidth: .infinity) // Ensures consistent parent view width
    }
}

#Preview {
    @Previewable @StateObject var accountLoader = AccountLoader()
    CookiesView().environmentObject(accountLoader)
}
