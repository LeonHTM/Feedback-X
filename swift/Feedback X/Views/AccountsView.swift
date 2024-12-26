//
//  AccountsView.swift
//  Feedback X
//
//  Created by LeonHTM on 14.12.2024.
//  Copyright © 2024 LeonHTM. All rights reserved.
//


import SwiftUI

struct RecentAccountsView: View {
    let folderPath = "/Users/leon/Desktop/Feedback-X/python/accounts/accounts.txt"
    @State private var accountData: [(relay: String, account: String, password: String, country: String, icloudmail: String, appledev: String, cookies: String)] = []
    @Binding var selectedAccount: (relay: String, account: String, password: String, country: String, icloudmail: String, appledev: String, cookies: String)?
    @Binding var selectedIndex: Int?
    
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing:0) {
                    if accountData.isEmpty {
                        Text("No files found or folder is empty.")
                            .foregroundColor(.gray)
                    } else {
                        ForEach(accountData.indices, id: \.self) { index in
                            let account = accountData[index]
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
                                    if account.cookies == "y"{
                                        Text("Cookies: ✅")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                            .lineLimit(1)
                                    }else{
                                        Text("Cookies: ❌")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                            .lineLimit(1)
                                        
                                    }
                                }
                                .padding([.leading, .trailing], 20)
                                .padding(.vertical, 5)
                                .background(selectedAccount?.icloudmail == account.icloudmail ? Color.accentColor : Color.clear)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .contentShape(RoundedRectangle(cornerRadius: 8))
                            }
                            .buttonStyle(PlainButtonStyle())

                            
                            
                            
                            if index < accountData.count - 1 {
                                Divider()
                                    
                            }
                        }
                    }
                }.padding([.leading, .trailing],5)

                .onAppear {
                    accountData = AccountLoader.loadAccounts(from: folderPath)
                }
            }
        }//.frame(width:300)
    }
}
struct DetailAccountsView: View {
    let accountToShow: (relay: String, account: String, password: String, country: String, icloudmail: String, appledev: String, cookies: String,index: Int)
    @State private var hoveredPassword: Bool = false
    @State private var showDeleteAlert: Bool = false
    @State private var editingMode:Bool = false
    @State private var editingButtonDisable:Bool = false
    
    @State private var icloudmailSave: String = "Wallah billah"
    

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                HStack {
                    Spacer()
                    VStack(alignment: .leading) {
                        VStack {
                            VStack(alignment: .leading, spacing: 20) {
                                ZStack{
                                    VStack(alignment: .leading, spacing: 10) {
                                        HStack {
                                            Button(action:{hoveredPassword.toggle()}){
                                                ZStack{
                                                    Image(systemName: hoveredPassword ? "lock.open.fill":"lock.fill")
                                                        .font(.system(size: 40))
                                                        .frame(width: 70, height: 70)
                                                        .background(
                                                            RoundedRectangle(cornerRadius: 15)
                                                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                                                .fill(Color.accentColor)
                                                        )
                                                    
                                                    Text("\(accountToShow.index + 1)")
                                                        .padding(10)
                                                        .background(
                                                            Circle()
                                                                .stroke(Color.black.opacity(0.2), lineWidth: 1)
                                                                .fill(Color.gray)
                                                            
                                                        ).offset(x:30,y:30)
                                                    
                                                    
                                                }
                                            }.buttonStyle(PlainButtonStyle())
                                            VStack(alignment: .leading) {
                                                Text(accountToShow.icloudmail)
                                                    .font(.title)
                                                    .fontWeight(.bold)
                                                Text("Added: 01.01.2025")
                                                    .foregroundStyle(.secondary)
                                                    .padding(.vertical, -10)
                                            }
                                            
                                        }
                                        
                                        Divider()
                                        HStack {
                                            Text("User Name")
                                            Spacer()
                                            if editingMode == true{
                                                HStack{
                                                    Spacer()
                                                    TextField("",text: $icloudmailSave)
                                                        .foregroundStyle(.primary)
                                                        .textFieldStyle(PlainTextFieldStyle())
                                                        .multilineTextAlignment(.trailing)
                                                        .autocorrectionDisabled(true)
                                                        
                                                }
                                                
                                            }else{
                                                Text(accountToShow.icloudmail)
                                                    .foregroundStyle(.secondary)
                                            }
                                        }
                                        Divider()
                                        HStack {
                                            Text("Password")
                                            Spacer()
                                            Text(hoveredPassword ? accountToShow.password : String(repeating: "•", count: accountToShow.password.count))
                                                .foregroundStyle(.secondary)
                                                .font(.system(.body, design: .monospaced))
                                                .onHover { hovering in
                                                    hoveredPassword = hovering
                                                }
                                        }
                                        Divider()
                                        HStack {
                                            Text("Country")
                                            Spacer()
                                            Text(accountToShow.country)
                                                .foregroundStyle(.secondary)
                                        }
                                        Divider()
                                        HStack {
                                            Text("Cookies")
                                            Spacer()
                                            if accountToShow.cookies == "y" {
                                                Text("✅")
                                            } else {
                                                Text("❌")
                                            }
                                        }
                                        Divider()
                                        HStack {
                                            Text("Apple Developer Account")
                                            Spacer()
                                            if accountToShow.appledev == "y" {
                                                Text("✅")
                                            } else {
                                                Text("❌")
                                            }
                                        }
                                        Divider()
                                        VStack(alignment: .leading) {
                                            HStack {
                                                Text("Notes")
                                                Spacer()
                                            }
                                            Text("notes 8979p747p93749p57p39475p9372p9759p3874589p732979834725p9237p597389475p932847589p27983275p47p39824759p325p98327495p3729p")
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                    .padding()
                                    
                                    Button(action: {
                                        editingMode.toggle()
                                        editingButtonDisable = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                            editingButtonDisable = false
                                        }
                                    }) {
                                        Text(editingMode ? "Save" : "Edit")
                                    }
                                    .disabled(editingButtonDisable)
                                    .offset(x: geometry.size.width * 0.5 - 50, y: -150)
                                    if editingMode == true{
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
                                        .offset(x: geometry.size.width * 0.5 - 105, y: -150)
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
                        
                        Text("Security")
                            .fontWeight(.bold)
                            .padding(.leading, 15)
                            .padding(.vertical, 10)
                            .padding(.bottom, -10)
                        
                        VStack(alignment: .center, spacing: 10) {
                            HStack {
                                Spacer()
                                Image(systemName: "exclamationmark.circle.fill")
                                    .font(.system(size: 25)) // Set the size to 30
                                    .foregroundColor(.yellow) // Set the color to yellow
                                Spacer()
                            }
                            Text("Passwords are stored in plain text.")
                                .font(.title3)
                            Text("In the current version of this app, passwords are stored in plain text, which means anyone with access to your device can see them in the system files. So, please don’t enter your main Apple account. Instead, create separate Apple accounts specifically for duplicating feedbacks. I’ll consider encrypting sensitive data in future versions of this application.")
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
                        HStack{
                            Spacer()
                            VStack(alignment: .center, spacing: 10) {
                                Button(action:{showDeleteAlert.toggle()}){
                                    HStack{
                                        Image(systemName: "trash")
                                        Text("Delete Account")
                                    }.foregroundStyle(.red)
                                    
                                }.alert(isPresented: $showDeleteAlert) {
                                    Alert(
                                        title: Text("Attention"),
                                        message: Text("Are you sure you want to delete Account \(accountToShow.icloudmail)?"),
                                        primaryButton: .destructive(Text("Confirm")) {
                                            // Clear accounts file line here
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
    @State private var selectedAccount: (relay: String, account: String, password: String, country: String, icloudmail: String, appledev: String, cookies: String)? = nil
    @State private var selectedIndex: Int? = nil

    var body: some View {
        HSplitView {
            RecentAccountsView(selectedAccount: $selectedAccount, selectedIndex: $selectedIndex)
                .frame(minWidth: 250, maxWidth: .infinity)

            if let account = selectedAccount, let index = selectedIndex {
                DetailAccountsView(accountToShow: (relay: account.relay, account: account.account, password: account.password, country: account.country, icloudmail: account.icloudmail, appledev: account.appledev, cookies: account.cookies, index: index))
                    .frame(minWidth: 500, maxWidth: 1250) // Fill remaining space when a file is selected
            } else {
                CreateAccountView()
                    .frame(minWidth: 500, maxWidth: 1250, maxHeight: .infinity) // Fill remaining space when no file is selected
            }
        }
        Spacer()
    }
}




#Preview{
    DetailAccountsView(accountToShow: (relay:"stfu",account:"stfu",password:"stfu",country:"stfu",icloudmail:"stfu",appledev:"stfu",cookies:"stfu",index:0))
}
 
/*
#Preview{
    CombinedAccountView()
}
 */
