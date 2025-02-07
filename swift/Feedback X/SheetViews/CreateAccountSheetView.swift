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
    @AppStorage("helpSelectedPage") var helpSelectedPage: String = "Create Accounts"
    @State private var icloudmailSave: String = ""
    @State private var passwordSave: String = ""
    @State private var noteSave: String = "Notes"
    @State private var cookiesSave = "n"
    @State private var appledevSave = ""
    @State private var countrySave: String = ""
    @State private var isEmailInvalid = false
    @State private var debounceWorkItem: DispatchWorkItem?
    @State private var alreadyClicked: Bool = false
    
    @State var dateSave = Calendar.current.date(byAdding: .day, value: 30, to: Date())?
        .formatted(Date.FormatStyle()
            .day(.defaultDigits)
            .month(.defaultDigits)
            .year())
    
    @State private var showFileImporter = false
    @State private var selectedFiles: [String] = []
    @State private var showAlert = false
    @State private var errorMessage: String = ""
    
    @State private var showCloseAlert = false
    @State private var showDuplicateAlert = false
    @Binding var showSheet: Bool
    @Environment(\.colorScheme) var colorScheme
    
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
                    .padding(.bottom,-10)
                    .offset(x:3)
                
               
                    
                HStack(spacing:0){
                    if alreadyClicked == true && icloudmailSave.isEmpty{
                        Image(systemName:"arrow.right.circle.fill")
                            .foregroundStyle(Color.red)
                            .padding(.horizontal,-17)
                    }
                    TextField("Mail", text: $icloudmailSave)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: icloudmailSave) {
                            debounceWorkItem?.cancel() // Cancel the previous work item
                            debounceWorkItem = DispatchWorkItem {
                                let emailRegex = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$"
                                let isValid = icloudmailSave.range(of: emailRegex, options: [.regularExpression, .caseInsensitive]) != nil
                                isEmailInvalid = !isValid && !icloudmailSave.isEmpty
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: debounceWorkItem!)
                        }
                }
                    
                
                if isEmailInvalid{
                    HStack {
                        Image(systemName: "exclamationmark.circle")
                        Text("Enter a valid email address")
                    }
                    .foregroundStyle(Color.red)
                    .padding(.vertical,-15)
                    .offset(x:3,y:3)
                }


                
                HStack(alignment:.center,spacing:0){
                    if alreadyClicked == true && passwordSave.isEmpty{
                        Image(systemName:"arrow.right.circle.fill")
                            .foregroundStyle(Color.red)
                            .padding(.horizontal,-17)
                            .padding(.vertical,0)
                            .offset(y:-5)
                    }
                    SecureInputView("Password", text: $passwordSave)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.top,-10)
                }
                HStack(alignment: .top,spacing: 5) {
                    Image(systemName: "exclamationmark.circle.fill").foregroundStyle(.yellow).offset(y:1)
                    Text("In the current version of this app, passwords are stored in plain text, which means anyone with access to your device can find them if they dig deep enough into the system files. While this isn’t a significant issue if you use passwords that you don’t use elsewhere, please avoid using passwords that you use in other places.")
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.leading)
                }
                
                   
                 
                Text("Details")
                    .font(.title)
                    .fontWeight(.bold)
                
                
                HStack(spacing:0){
                    if alreadyClicked == true && appledevSave.isEmpty{
                        Image(systemName:"arrow.right.circle.fill")
                            .foregroundStyle(Color.red)
                            .padding(.horizontal,-17)
                            .offset(y:5)
                    }
                    
                    Text("Does the Account have Apple Developer?")
                        .padding(.bottom,-10)
                        .offset(x:3)
                        
                }
               
                    
                ZStack(alignment:.leading){
                    
                    Picker("", selection: $appledevSave) {
                        Text("Set up").tag("y")
                        Text("Not set up").tag("n")
                    }.labelsHidden()
                    if appledevSave == ""{
                        Text("Apple Developer").padding(.leading, 7)
                            .foregroundStyle(.primary.opacity(0.7))
                            .opacity(0.5)
                    }
                }
                
                /*
                Text("Does the account have stored cookies?")
                ZStack(alignment:.leading){
                    if cookiesSave == ""{
                        Text("Cookies").padding(.leading, 7)
                            .foregroundStyle(.secondary)
                            .opacity(0.5)
                    }
                    Picker("", selection: $cookiesSave) {
                        Text("Has stored cookies").tag("y")
                        Text("Doesn't have stored cookies").tag("n")
                    }.labelsHidden()
                }*/
                HStack(spacing:0){
                    if alreadyClicked == true && countrySave.isEmpty{
                        
                        
                        Image(systemName:"arrow.right.circle.fill")
                            .foregroundStyle(Color.red)
                            .padding(.horizontal,-17)
                            .offset(y:5)
                    }
                    Text("Please select the country of origin")
                        .padding(.bottom,-10)
                        .offset(x:3)
                }
           
                    
                ZStack(alignment:.leading){
                    
                    Picker("", selection: $countrySave) {
                        ForEach(PublicSaves.countriesAndTerritories, id: \.self) { country in
                            Text(country)
                        }
                    }.labelsHidden()
                    if countrySave == ""{
                        Text("Country").padding(.leading, 7)
                            .foregroundStyle(.primary.opacity(0.5))
                            .opacity(0.5)
                    }
                }
                
            
                
                

                // Description Section
                
                Text("Add note")
                    .padding(.bottom,-10)

                TextEditor(text: $noteSave)
                    .frame(height: 100)
                    .border(Color.gray, width: 1)
          
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
        }
        .padding(.bottom,-9.5)
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
                helpSelectedPage = "Add Accounts"
                OpenHelpWindow.open()
                
                
            }) {
                ZStack{
                    Image(systemName: "circle.fill")
                        .font(.system(size:20))
                        .foregroundStyle(colorScheme == .dark ? Color.gray.opacity(0.5) : Color.white)
                        .shadow(radius: 1)
                    Text("?")
                        .foregroundStyle(colorScheme == .dark ? Color.white : Color.black)
                        .font(.system(size:17))
                    
                }
                    
                    
            }
            .buttonStyle(PlainButtonStyle())
            .padding()
            

    
            Spacer()
            Button(action: {
                showSheet = false
            }) {
                Text("Close")
                    .padding(5) // Add padding around the text
            }
            
            
            
            
            
            Button(action: {
                
                
                alreadyClicked = true
                
                if isSubmitEnabled == true{
                    
                    if cookiesSave != "y"{
                        
                        dateSave = nil
                        
                    }
                    
                    
                    let newAccount = Account(
                        account: icloudmailSave,
                        icloudmail: icloudmailSave,
                        password: passwordSave,
                        relay: icloudmailSave,
                        country: countrySave,
                        appledev: appledevSave,
                        cookies: "n",
                        note: noteSave,
                        date: dateSave ?? "No cookies added yet"
                    )
                    
                    if accountLoader.addAccount(newAccount, to: accountURL) == false {
                        showDuplicateAlert = true
                    } else {
                        showSheet = false
                    }
                }
            }) {
                Text("Save")
                    .padding(.vertical,6.3)
                    .padding(.horizontal,10) // Add padding around the text
            }
            //.disabled(!isSubmitEnabled)
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
            .buttonStyle(PlainButtonStyle())
            .background(Color.accentColor)
            .foregroundColor(.white)
            .cornerRadius(5)
            .padding([.trailing,])

        }
        .padding(.top,-9.5)
        .frame(width:1000)
        
        
        
    }
       
}


#Preview{
    @Previewable @StateObject var accountLoader = AccountLoader()
    CreateAccountSheetView(showSheet: .constant(true)).environmentObject(accountLoader)
}
