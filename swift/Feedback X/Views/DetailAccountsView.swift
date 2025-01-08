//
//  DetailAccountView.swift
//  Feedback X
//
//  Created by Leon  on 08.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import SwiftUI

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
        
        let dateSaveNow = Date().formatted(Date.FormatStyle()
                .day(.defaultDigits)
                .month(.defaultDigits)
                .year())
        
        
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
        
        func convertToDate(dateString: String) -> Date? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d.M.yyyy" // No leading zeros
            return dateFormatter.date(from: dateString)
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
                                                            .onChange(of: indexToShow){
                                                               editingMode = false
                                                               icloudmailSave = ""
                                                                passwordSave = ""
                                                               countrySave = "DrakyLand"
                                                               cookiesSave = "n"
                                                               appledevSave = "n"
                                                                noteSave = "Notes"
                                                                 dateSave = "1.1.2025"
                                                               
                                                            }
                                                        
                                                    }
                                                }
                                                .buttonStyle(PlainButtonStyle())
                                                VStack(alignment: .leading) {
                                                    Text(accountToShow.icloudmail)
                                                        .font(.title)
                                                        .fontWeight(.bold)
                                                    HStack{
                                                        
                                                        
                                                        if let cookieDate = convertToDate(dateString: accountToShow.date),
                                                           let currentDate = convertToDate(dateString: dateSaveNow) {
                                                            
                                                            let calendar = Calendar.current
                                                            let components = calendar.dateComponents([.day], from: currentDate, to: cookieDate)
                                                            
                                                            if let daysDifference = components.day {
                                                                if daysDifference  > 0 {
                                                                    Text("Cookies expire in \(String(daysDifference)) days. (\(accountToShow.date))")
                                                                        .foregroundStyle(.secondary)
                                                                        .padding(.vertical, -10)
                                                                }else if daysDifference == 0 {
                                                                    Text("Cookies have expired today")
                                                                        .foregroundStyle(.yellow)
                                                                        .padding(.vertical, -10)
                                                                    
                                                                }else if daysDifference < 0{
                                                                    
                                                                    Text("Cookies expired \(String(abs(daysDifference))) days ago. (\(accountToShow.date))")
                                                                        .foregroundStyle(.yellow)
                                                                        .padding(.vertical, -10)
                                                                }
                                                            }
                                                        }else{
                                                            
                                                            
                                                            Text("No cookies yet")
                                                                .foregroundStyle(.secondary)
                                                                .padding(.vertical, -10)
                                                        }
                                                        
                                                       
                                                        
                                                    }
                                                        
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
                                                        .onAppear {
                                                            icloudmailSave = accountToShow.icloudmail
                                                            dateSave = accountToShow.date
                                                        }
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
                                                    if accountToShow.cookies == "No cookies added yet" {
                                                        Picker("", selection: $cookiesSave) {
                                                            Text("Accepted").tag("y")
                                                            Text("Not Accepted").tag("n")
                                                        }
                                                        .onAppear { cookiesSave = accountToShow.cookies }
                                                        .frame(width: 150)
                                                    }else{
                                                        Text("No cookies added yet")
                                                    }
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
                                            
                                            if noteSave.range(of: "[a-zA-Z0-9]", options: .regularExpression) == nil {
                                                noteSave = "Notes"
                                            }

                                            
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
                            
                            
                            if let cookieDate = convertToDate(dateString: accountToShow.date),
                               let currentDate = convertToDate(dateString: dateSaveNow) {
                                
                                
                                if currentDate >= cookieDate{
                                    Text("Cookies Expired")
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
                                        Text("Cookies for this Account have expired.")
                                            .font(.title3)
                                        Text("The Cookies for this account have expired. Feedback X can not perform any duplications on this account anymore. Please renew the cookies in the cookies section..")
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
                                }
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

