//
//  CreateAccountSheetView.swift
//  Feedback X
//
//  Created by Leon  on 02.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import SwiftUI

struct CreateAccountSheetView: View {
    
    let accountURL = URL(fileURLWithPath: "/Users/leon/Desktop/Feedback-X/python/accounts/accounts.json")
    @EnvironmentObject var accountLoader: AccountLoader
    
    @State private var icloudmailSave: String = ""
    @State private var passwordSave: String = ""
    @State private var noteSave: String = ""
    @State private var cookiesSave = ""
    @State private var appledevSave = ""
    @State private var countrySave: String = ""
    
    let dateSave = Date().formatted(Date.FormatStyle()
        .day(.defaultDigits)
        .month(.defaultDigits)
        .year())
    
    @State private var showFileImporter = false
    @State private var selectedFiles: [String] = []
    @State private var showAlert = false
    @State private var errorMessage: String = ""
    
    @State private var showCloseAlert = false
    @State public var showHelpSheet = false
    @State private var showDuplicateAlert = false
    @Binding var showSheet: Bool
    
    private var isSubmitEnabled: Bool {
        return !icloudmailSave.isEmpty && !passwordSave.isEmpty && !cookiesSave.isEmpty && !appledevSave.isEmpty && !countrySave.isEmpty
        }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text("Basic Information")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Please provide the icloud login credentials")
                TextField("Mail", text: $icloudmailSave)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            
                SecureInputView("Password", text: $passwordSave)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top,-10)
                VStack(alignment: .center, spacing: 10) {
                    HStack {
                        Spacer()
                        Image(systemName: "exclamationmark.circle.fill")
                            .font(.system(size: 25))
                            .foregroundColor(.yellow)
                        Spacer()
                    }
                    Text("In the current version of this app, passwords are stored in plain text, which means anyone with access to your device can see them in the system files. If you dont use password and or icloud accounts you use elsewhere this isn't a issue. Therefore please never use data you use in other places.")
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                        .fill(Color.gray.opacity(0.1))
                )
                .padding(.horizontal, 10)
                   
                 
                Text("Details")
                    .font(.title)
                    .fontWeight(.bold)
                
                
                
                Text("Does the Account have Apple Developer?")
                
                ZStack(alignment:.leading){
                    if cookiesSave == ""{
                        Text("Apple Developer").padding(.leading, 7)
                            .foregroundStyle(.secondary)
                            .opacity(0.5)
                    }
                    Picker("", selection: $cookiesSave) {
                        Text("Set up").tag("y")
                        Text("Not set up").tag("n")
                    }.labelsHidden()
                }
                
                Text("Does the account have stored cookies?")
                ZStack(alignment:.leading){
                    if appledevSave == ""{
                        Text("Cookies").padding(.leading, 7)
                            .foregroundStyle(.secondary)
                            .opacity(0.5)
                    }
                    Picker("", selection: $appledevSave) {
                        Text("Accepted").tag("y")
                        Text("Not accepted").tag("n")
                    }.labelsHidden()
                }
                
                Text("Please select the country of origin")
                ZStack(alignment:.leading){
                    if countrySave == ""{
                        Text("Country").padding(.leading, 7)
                            .foregroundStyle(.secondary)
                            .opacity(0.5)
                    }
                    Picker("", selection: $countrySave) {
                        ForEach(CountryList.countriesAndTerritories, id: \.self) { country in
                            Text(country)
                        }
                    }.labelsHidden()
                }
            
                
                

                // Description Section
                
                Text("Add note")

                TextEditor(text: $noteSave)
                    .frame(height: 100)
                    .border(Color.gray, width: 1)
                
               
                
            
                

                
                
                
                
                
                
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
        }
        .onAppear {
                        accountLoader.loadAccounts(from: accountURL) 
                    }
        .alert("Error", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(errorMessage)
        }
        Divider()
        HStack{
            Button(action: {
                showHelpSheet = true
                
                
            }) {
                Image(systemName: "questionmark.circle.fill")
                    .font(.system(.title2))
                    .foregroundColor(.gray)
                    
                    
            }
            .buttonStyle(PlainButtonStyle())
            .padding()
            .sheet(isPresented: $showHelpSheet) {
                HelpMeView()
                    .frame(minWidth: 1100, minHeight: 750) // Add minimum width and height here
            }

    
            Spacer()
            if isSubmitEnabled == false{
                Text("You haven't filled every field yet")}
            Button(action: {
                showSheet = false
            }) {
                Text("Close")
                    .padding(5) // Add padding around the text
            }
            
            
            
            
            
            Button(action: {
                let newAccount = Account(
                    account: icloudmailSave,
                    icloudmail: icloudmailSave,
                    password: passwordSave,
                    relay: icloudmailSave,
                    country: countrySave,
                    appledev: appledevSave,
                    cookies: cookiesSave,
                    note: noteSave,
                    date: dateSave
                )
                
                if accountLoader.addAccount(newAccount, to: accountURL) == false {
                    showDuplicateAlert = true
                } else {
                    showSheet = false
                }
            }) {
                Text("Submit")
                    .padding(5) // Add padding around the text
            }
            .disabled(!isSubmitEnabled)
            .alert("Account already exists", isPresented: $showDuplicateAlert) {
                
                Button("Quit Add Account", role: .cancel) {
                    showSheet = false
                }
                Button("OK", role: .cancel) {
                    // This is where we handle the alert dismissing logic
                    showDuplicateAlert = false
                }
            } message: {
                Text("The account you tried to add already exists.")
            }
            .background(isSubmitEnabled ? Color.accentColor: Color.gray)
            .foregroundColor(.white)
            .cornerRadius(5)
            .padding([.trailing,])

        }.frame(width:1000)
        
        
        
    }
       
}



