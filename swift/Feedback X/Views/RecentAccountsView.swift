//
//  RecentAccountsView.swift
//  Feedback X
//
//  Created by Leon  on 08.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import SwiftUI

struct RecentAccountsView: View {
    
        
        @AppStorage("AccountshowSheet1") var showSheet: Bool = false
        @State private var accountURL = URL(fileURLWithPath: "/Users/leon/Desktop/Feedback-X/python/accounts/accounts.json")
        @State private var showDeleteAlert: Bool = false
        
        @EnvironmentObject var accountLoader: AccountLoader
        @Binding var selectedAccount: Account?
        @Binding var selectedIndex: Int?
        @Binding var editingMode: Bool
        
        
        let dateSaveNow = Date().formatted(Date.FormatStyle()
                .day(.defaultDigits)
                .month(.defaultDigits)
                .year())
        
        func convertToDate(dateString: String) -> Date? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d.M.yyyy" // No leading zeros
            return dateFormatter.date(from: dateString)
        }


        var body: some View {
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
                                                    .foregroundStyle(selectedIndex == index ? Color.white : Color.primary)
                                                
                                                Spacer()
                                                Text(account.country)
                                                    .font(.subheadline)
                                                    .foregroundStyle(selectedIndex == index ? Color.white.opacity(0.7) : Color.secondary)
                                            }
                                            HStack{
                                                if index <= 9 {
                                                    if account.cookies == "y" {
                                                        Text("Cookies: ✅")
                                                            .font(.subheadline)
                                                            .foregroundStyle(selectedIndex == index ? Color.white.opacity(0.7) : Color.secondary)
                                                            .lineLimit(1)
                                                            .onAppear{
                                                                
                                                                
                                                                
                                                                
                                                                if let cookieDate = convertToDate(dateString: account.date),
                                                                   let currentDate = convertToDate(dateString: dateSaveNow) {
                                                                    if currentDate >= cookieDate{
                                                                        
                                                                        let updatedAccountCookies = Account(
                                                                            account: account.account,
                                                                            icloudmail: account.icloudmail,
                                                                            password: account.password,
                                                                            relay: account.relay,
                                                                            country: account.country,
                                                                            appledev: account.appledev,
                                                                            cookies: "n",
                                                                            note: account.note,
                                                                            date: account.date
                                                                        )
                                                                        
                                                                        accountLoader.editAccount(at: index, with: updatedAccountCookies, to: accountURL)
                                                                    }
                                                                    
                                                                    
                                                                    
                                                                }
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                            }
                                                        
                                                        
                                                        
                                                        
                                                        
                                                    } else {
                                                        Text("Cookies: ❌")
                                                            .font(.subheadline)
                                                            .foregroundStyle(selectedIndex == index ? Color.white.opacity(0.7) : Color.secondary)
                                                            .lineLimit(1)
                                                    }
                                                }else{
                                                    
                                                    Text("This Account can't be used to duplicate feedback")
                                                        .font(.subheadline)
                                                        .foregroundStyle(selectedIndex == index ? Color.white.opacity(0.7) : Color.secondary)
                                                        .lineLimit(1)
                                                }
                                                
                                                /*
                                                if account.appledev == "y"{
                                                    Text("Apple Dev: ✅")
                                                        .font(.subheadline)
                                                        .foregroundStyle(selectedAccount?.id == account.id ? Color.white.opacity(0.7) : Color.secondary)
                                                        .lineLimit(1)
                                                }else{
                                                    
                                                    Text("Apple Dev: ❌")
                                                        .font(.subheadline)
                                                        .foregroundStyle(selectedAccount?.id == account.id ? Color.white.opacity(0.7) : Color.secondary)
                                                        .lineLimit(1)
                                                }*/
                                                
                                            }
                                            
                                        }
                                        .padding([.leading, .trailing], 20)
                                        .padding(.vertical, 5)
                                        .background(selectedIndex == index ? Color.accentColor : Color.clear)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .contentShape(RoundedRectangle(cornerRadius: 8))
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .alert(isPresented: $showDeleteAlert) {
                                        Alert(
                                            title: Text("Delete \(selectedAccount?.icloudmail ?? "Unknown")?"),
                                            message: Text("Are you sure you want to delete \(selectedAccount?.icloudmail ?? "Unknown") ?"),
                                            primaryButton: .destructive(Text("Confirm")) {
                                                
                                                accountLoader.deleteAccount(by: selectedAccount?.icloudmail ?? "Unknown", to: accountURL)
                                                
                                                if let currentIndex = selectedIndex {
                                                    if currentIndex > 0 {
                                                        self.selectedIndex = currentIndex - 1
                                                        self.selectedAccount = accountLoader.accounts[self.selectedIndex!]
                                                    } else {
                                                        self.selectedIndex = nil
                                                        self.selectedAccount = nil
                                                    }
                                                }
                                                

                                               
                                                
                                            },
                                            secondaryButton: .cancel()
                                        )
                                    }
                                    .contextMenu {
                                        
                                        Button(role: .destructive) {
                                            selectedAccount = account
                                            selectedIndex = index
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                editingMode = true
                                            }
                                            print(String(editingMode))
                                        } label: {
                                            Label("Edit", systemImage: "pencil")
                                        }
                                        Button(role: .destructive) {
                                            showDeleteAlert = true
                                            selectedAccount = account
                                            selectedIndex = index
                                           
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                        
                                        
                                        
                                        
                                    }
                                    
                                    if index < accountLoader.accounts.count - 1 {
                                        Divider()
                                    
                                    }
                                    
                                }
                               
                                
                               

                            }
                        }
                    }
                    .padding([.leading, .trailing], 5)
                    
                    
                    
                    
                }
        
            
            
            
            .onAppear {
                accountLoader.loadAccounts(from: accountURL) // Ensure path is passed here
            }
        }
    }
   

