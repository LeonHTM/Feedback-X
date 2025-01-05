//
//  AccountsView.swift
//  Feedback X
//
//  Created by LeonHTM on 14.12.2024.
//  Copyright © 2024 LeonHTM. All rights reserved.
//

import SwiftUI

struct RecentAccountsView: View {
    
    @State private var showSheet = false
    @State private var accountURL = URL(fileURLWithPath: "/Users/leon/Desktop/Feedback-X/python/accounts/accounts.json")
    
    @EnvironmentObject var accountLoader: AccountLoader
    @Binding var selectedAccount: Account?
    @Binding var selectedIndex: Int?


    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    if accountLoader.accounts.isEmpty {
                        Text("No Accounts in Directory")
                            .foregroundColor(.gray)
                            .padding(10)
                    } else {
                        VStack(spacing:0){
                            Button(action: {
                                showSheet.toggle() // Toggle the correct state
                            }) {
                                Text(isRunning ? "Adding New Account" : "Add Account")
                                    .padding(1)
                            }
                            .disabled(isRunning)
                            .sheet(isPresented: $showSheet) {
                                CreateAccountSheetView(showSheet: $showSheet)
                                    .environmentObject(accountLoader)
                            }
                            .padding(10)
                            
                            ForEach(accountLoader.accounts.indices, id: \.self) { index in
                                let account = accountLoader.accounts[index]
                                Button(action: {
                                    selectedAccount = account
                                    selectedIndex = index
                                }) {
                                    VStack(alignment: .leading, spacing: 8) {
                                        HStack {
                                            Text(account.icloudmail.isEmpty ? "Untitled" : account.icloudmail)
                                                .font(.headline)
                                                .lineLimit(1)
                                            
                                            Spacer()
                                            Text(account.country)
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                        if account.cookies == "y" {
                                            Text("Cookies: ✅")
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                                .lineLimit(1)
                                        } else {
                                            Text("Cookies: ❌")
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                                .lineLimit(1)
                                        }
                                    }
                                    .padding([.leading, .trailing], 20)
                                    .padding(.vertical, 5)
                                    .background(selectedAccount?.id == account.id ? Color.accentColor : Color.clear)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .contentShape(RoundedRectangle(cornerRadius: 8))
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                                if index < accountLoader.accounts.count - 1 {
                                    Divider()
                                }
                            }
                        }
                    }
                }
                .padding([.leading, .trailing], 5)
            }
        }
        .onAppear {
            accountLoader.loadAccounts(from: accountURL) // Ensure path is passed here
        }
    }
}




 
 struct DetailAccountsView: View {
     @Binding var accountToShow: Account
     let indexToShow: Int
     @EnvironmentObject var accountLoader: AccountLoader
     
     
     public let onDelete: () -> Void
     let accountURL = URL(fileURLWithPath: "/Users/leon/Desktop/Feedback-X/python/accounts/accounts.json")
     
     @State private var hoveredPassword: Bool = false
     @State private var showDeleteAlert: Bool = false
     @State private var editingMode: Bool = false
     @State private var editingButtonDisable: Bool = false
     
     @State private var icloudmailSave: String = ""
     @State private var passwordSave: String = ""
     @State private var countrySave: String = "DrakyLand"
     @State private var cookiesSave: String = "n"
     @State private var appledevSave: String = "n"
     @State private var noteSave: String = "Notes"
     @State private var dateSave: String = "01.01.2025"
     
     @State private var currentIndex: Int = 0 // Track the current index
     
     @State private var yoffset: Int = -125
     
     
     
     
     func saveAccount() {
         // Create a new Account with the updated values
         let updatedAccount = Account(
             account: accountToShow.account,
             icloudmail: icloudmailSave,
             password: passwordSave,
             relay: accountToShow.relay,
             country: countrySave,
             appledev: appledevSave,
             cookies: cookiesSave,
             note: noteSave,
             date: dateSave
         )
         
         accountLoader.editAccount(at: indexToShow, with: updatedAccount, to: accountURL)
     }
     
     var body: some View {
         GeometryReader { geometry in
             ScrollView {
                 HStack {
                     Spacer()
                     VStack(alignment: .leading) {
                         VStack {
                             VStack(alignment: .leading, spacing: 20) {
                                 ZStack {
                                     VStack(alignment: .leading, spacing: 10) {
                                         HStack {
                                             Button(action: {
                                                 if !editingMode {
                                                     hoveredPassword.toggle()
                                                 }
                                             }) {
                                                 ZStack {
                                                     Image(systemName: hoveredPassword ? "lock.open.fill" : "lock.fill")
                                                         .font(.system(size: 40))
                                                         .frame(width: 70, height: 70)
                                                         .background(
                                                            RoundedRectangle(cornerRadius: 15)
                                                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                                                .fill(Color.accentColor)
                                                         )
                                                     
                                                     Text("\(indexToShow + 1)") // Display account ID
                                                         .padding(10)
                                                         .background(
                                                            Circle()
                                                                .stroke(Color.black.opacity(0.2), lineWidth: 1)
                                                                .fill(Color.gray)
                                                         )
                                                         .offset(x: 30, y: 30)
                                                 }
                                             }
                                             .buttonStyle(PlainButtonStyle())
                                             VStack(alignment: .leading) {
                                                 Text(accountToShow.icloudmail)
                                                     .font(.title)
                                                     .fontWeight(.bold)
                                                 Text("Added: \(accountToShow.date)")
                                                     .foregroundStyle(.secondary)
                                                     .padding(.vertical, -10)
                                             }
                                         }
                                         
                                         Divider()
                                         
                                         // User Name Section
                                         HStack {
                                             Text("User Name")
                                             Spacer()
                                             if editingMode {
                                                 TextField("", text: $icloudmailSave)
                                                     .foregroundStyle(.primary)
                                                     .textFieldStyle(PlainTextFieldStyle())
                                                     .multilineTextAlignment(.trailing)
                                                     .onAppear { icloudmailSave = accountToShow.icloudmail }
                                             } else {
                                                 Text(accountToShow.icloudmail)
                                                     .foregroundStyle(.secondary)
                                             }
                                         }
                                         Divider()
                                         
                                         // Password Section
                                         HStack {
                                             Text("Password")
                                             Spacer()
                                             if editingMode {
                                                 TextField("", text: $passwordSave)
                                                     .foregroundStyle(.primary)
                                                     .textFieldStyle(PlainTextFieldStyle())
                                                     .multilineTextAlignment(.trailing)
                                                     .font(.system(.body, design: .monospaced))
                                                     .onAppear { passwordSave = accountToShow.password }
                                             } else {
                                                 Text(hoveredPassword ? accountToShow.password : String(repeating: "•", count: accountToShow.password.count))
                                                     .foregroundStyle(.secondary)
                                                     .font(.system(.body, design: .monospaced))
                                                     .onHover { hovering in
                                                         hoveredPassword = hovering
                                                     }
                                             }
                                         }
                                         Divider()
                                         
                                         // Country Picker
                                         HStack {
                                             Text("Country")
                                             Spacer()
                                             if editingMode {
                                                 Picker("", selection: $countrySave) {
                                                     ForEach(CountryList.countriesAndTerritories, id: \.self) { country in
                                                         Text(country)
                                                     }
                                                 }
                                                 .onAppear { countrySave = accountToShow.country }
                                                 .frame(width: 150)
                                             } else {
                                                 Text(accountToShow.country)
                                                     .foregroundStyle(.secondary)
                                             }
                                         }
                                         Divider()
                                         
                                         // Cookies Picker
                                         HStack {
                                             Text("Cookies")
                                             Spacer()
                                             if editingMode {
                                                 Picker("", selection: $cookiesSave) {
                                                     Text("Accepted").tag("y")
                                                     Text("Not Accepted").tag("n")
                                                 }
                                                 .onAppear { cookiesSave = accountToShow.cookies }
                                                 .frame(width: 150)
                                             } else {
                                                 Text(accountToShow.cookies == "y" ? "✅" : "❌")
                                             }
                                         }
                                         Divider()
                                         
                                         // Apple Developer Account Picker
                                         HStack {
                                             Text("Apple Developer Account")
                                             Spacer()
                                             if editingMode {
                                                 Picker("", selection: $appledevSave) {
                                                     Text("Set up").tag("y")
                                                     Text("Not set up").tag("n")
                                                 }
                                                 .onAppear { appledevSave = accountToShow.appledev }
                                                 .frame(width: 150)
                                             } else {
                                                 Text(accountToShow.appledev == "y" ? "✅" : "❌")
                                             }
                                         }
                                         
                                         if accountToShow.note != "Notes" && !editingMode{
                                             Divider()
                                             
                                             VStack(alignment: .leading) {
                                                 HStack {
                                                     ScrollView{
                                                         Text(accountToShow.note)
                                                             .frame(maxWidth:.infinity,alignment:.leading)
                                                     }.frame(height: 50)
                                                     
                                                 }

                                                 
                                             }
                                             
                                         }else if editingMode{
                                             Divider()
                                             TextEditor(text: $noteSave)
                                                 .textEditorStyle(PlainTextEditorStyle())
                                                 .font(.body)
                                                 .foregroundStyle(noteSave == "Notes" ? Color.secondary : Color.primary)
                                                 .frame(height: 50)
                                                 .onAppear {
                                                     noteSave = accountToShow.note
                                                 }
                                                 .padding(.leading,-5)

                                                 
                                             
                                         }
                                         
                                     }
                                     .padding()
                                     
                                     // Save/Cancel Buttons
                                     Button(action: {
                                         editingMode.toggle()
                                         editingButtonDisable = true
                                         if !editingMode {
                                             saveAccount() // Save the updated account data
                                         }
                                         DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                             editingButtonDisable = false
                                         }
                                     }) {
                                         Text(editingMode ? "Save" : "Edit")
                                     }
                                     .disabled(editingButtonDisable)
                                     .offset(
                                         x: geometry.size.width * 0.5 - 50,
                                         y: editingMode ? -167 : (accountToShow.note != "Notes" ? -160 : -125)
                                     )



                                     
                                     if editingMode {
                                         Button(action: {
                                             editingMode.toggle()
                                             editingButtonDisable = true
                                             DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                 editingButtonDisable = false
                                             }
                                         }) {
                                             Text("Cancel")
                                         }
                                         .disabled(editingButtonDisable)
                                         .offset(x: geometry.size.width * 0.5 - 105, y: -167)
                                     }
                                 }
                             }
                             .background(
                                 RoundedRectangle(cornerRadius: 15)
                                     .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                     .fill(Color.gray.opacity(0.1))
                             )
                             .padding(10)
                         }
                         
                         // Security Section
                         Text("Security")
                             .fontWeight(.bold)
                             .font(.title3)
                             .padding(.leading, 15)
                             .padding(.vertical, 10)
                             .padding(.bottom, -10)
                         
                         VStack(alignment: .center, spacing: 10) {
                             HStack {
                                 Spacer()
                                 Image(systemName: "exclamationmark.circle.fill")
                                     .font(.system(size: 25))
                                     .foregroundColor(.yellow)
                                 Spacer()
                             }
                             Text("Passwords are stored in plain text.")
                                 .font(.title3)
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
                         
                         // Delete Account Section
                         HStack {
                             Spacer()
                             VStack(alignment: .center, spacing: 10) {
                                 Button(action: { showDeleteAlert.toggle() }) {
                                     HStack {
                                         Image(systemName: "trash")
                                         Text("Delete Account")
                                     }.foregroundStyle(.red)
                                 }
                                 .alert(isPresented: $showDeleteAlert) {
                                     Alert(
                                         title: Text("Attention"),
                                         message: Text("Are you sure you want to delete Account \(accountToShow.icloudmail)?"),
                                         primaryButton: .destructive(Text("Confirm")) {
                                             accountLoader.deleteAccount(by: accountToShow.icloudmail, to: accountURL)
                                             onDelete()
                                             
                                         },
                                         secondaryButton: .cancel()
                                     )
                                 }
                             }
                             .padding(.horizontal, 10)
                             Spacer()
                         }
                     }
                     Spacer()
                 }
             }
         }
         
     }
 }




struct CombinedAccountView: View {
   
    @State private var selectedAccount: Account? = nil
    @State private var selectedIndex: Int? = nil
    @EnvironmentObject var accountLoader: AccountLoader

    var body: some View {
        HSplitView {
            RecentAccountsView(selectedAccount: $selectedAccount, selectedIndex: $selectedIndex)
                .environmentObject(accountLoader)
                .frame(minWidth: 250, maxWidth: .infinity)

            if let selectedIndex = selectedIndex, selectedIndex >= 0, selectedIndex < accountLoader.accounts.count {
                // Show DetailAccountsView if the selectedIndex is valid
                DetailAccountsView(
                    accountToShow: $accountLoader.accounts[selectedIndex],
                    indexToShow: selectedIndex,
                    onDelete: {
                        // Reset selected state
                        if let currentIndex = self.selectedIndex {
                            if currentIndex > 0 {
                                self.selectedIndex = currentIndex - 1
                                self.selectedAccount = accountLoader.accounts[self.selectedIndex!]
                            } else {
                                self.selectedIndex = nil
                                self.selectedAccount = nil
                            }
                        }
                    }
                )
                .environmentObject(accountLoader)
                .frame(minWidth: 575, maxWidth: 1250)
            } else {
                // Show CreateAccountView if no valid selectedIndex is available
                CreateAccountView()
                    .environmentObject(accountLoader)
                    .frame(minWidth: 575, maxWidth: 1250, maxHeight: .infinity)
            }
        }
    }
}





/*
struct ContentView: View {
    @State private var exampleAccount = Account(
        account: "john_doe",
        icloudmail: "john.doe@icloud.com",
        password: "password123",
        relay: "relay@example.com",
        country: "United States",
        appledev: "y", // y for accepted, n for not accepted
        cookies: "y",
        note: "Notes"
    )
    
    var body: some View {
        DetailAccountsView(accountToShow: $exampleAccount, indexToShow: 9)
    }
}
#Preview{
    ContentView()
}
*/
 /*
#Preview{
    CombinedAccountView()
}*/

