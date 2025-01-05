//
//  CookiesViewSheet.swift
//  Feedback X
//
//  Created by Leon  on 05.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import SwiftUI

struct CookiesSheetView: View {
    
    let accountURL = URL(fileURLWithPath: "/Users/leon/Desktop/Feedback-X/python/accounts/accounts.json")
    @EnvironmentObject var accountLoader: AccountLoader
    
    @State private var showAlert = false
    @State private var isSubmitEnabled = false
    
    @State private var showCloseAlert = false
    @State public var showHelpSheet = false
    @State private var showDuplicateAlert = false
    
    @State private var progress: Double = 0
    
    @Binding var showSheet: Bool
    

    var body: some View {
        ScrollView {
            
            VStack(alignment: .center, spacing: 15) {
                
                Text("Account \(Int(progress)) of 10")

                

                
                ForEach(accountLoader.accounts.indices, id: \.self) { index in
                    let account = accountLoader.accounts[index]
                    Text(account.icloudmail)
                    
                }
                
                ProgressView(value: progress)
                
                
                Button(action:{}){
                    
                    Text("Next")
                }
                
                
                
                Button(action:{}){
                    
                    Text("Try Again")
                }
                
                
                   
                
            }

        }.onAppear {
            accountLoader.loadAccounts(from: accountURL)
            
        }
        
        .alert("Error", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("wallah yo")
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
            .padding([.leading, .trailing, .bottom], 7)
            .padding(.top,5)
            .sheet(isPresented: $showHelpSheet) {
                HelpMeView()
                    .frame(minWidth: 1100, minHeight: 750) // Add minimum width and height here
            }

    
            Spacer()
           
            

        }.frame(width:1000)
        
        
        
    }
       
}
    
#Preview{
    @Previewable @StateObject var accountLoader = AccountLoader()
    CookiesSheetView(showSheet:.constant(true))
        .environmentObject(accountLoader)
}
