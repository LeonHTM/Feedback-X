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
    
    let accountURL = URL(fileURLWithPath: "/Users/leon/Desktop/Feedback-X/python/accounts/accounts.json")
    

     
    @EnvironmentObject var accountLoader: AccountLoader
    
    @State private var showAlert = false
    @State private var isSubmitEnabled = false
    
    @State private var showCloseAlert = false
    
    @State private var showDuplicateAlert = false
    
    @State public var selectedHelpPage:String = "Set up Cookies"
    
    //@State private var progress: Double = 0
    @State private var step: Double = 0
    @State private var buttonAllowed: Bool = true
    @State private var goneWrong: Bool = false
    
    @Binding var showSheet: Bool
    @Binding var selectedList: [Int]
    @Binding var waitingTime: Int
    
    @EnvironmentObject var cookiesPython: CookiesPython
    

    @State private var currentStep: Int = 0
    @State private var totalSteps: Int = 0
    
    @State var dateSave = Calendar.current.date(byAdding: .day, value: 30, to: Date())?
        .formatted(Date.FormatStyle()
            .day(.defaultDigits)
            .month(.defaultDigits)
            .year())
    
    
    
    var progress: Double {
        Double(currentStep) / Double(totalSteps)
    }
    
    @AppStorage("DeveloperSettings") var developerSettings: Bool = false
    
    
    

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 15) {
                if currentStep < totalSteps {
                    Text("Account \(currentStep + 1) of \(totalSteps)")
                        .font(.title)
                        .fontWeight(.bold)
                } else {
                    Text("All done")
                        .font(.title)
                        .fontWeight(.bold)
                }
                
                Text("Current Account:")
                
                if currentStep < totalSteps {
                    if !accountLoader.accounts.isEmpty {
                        Text(" \(accountLoader.accounts[selectedList[currentStep]].icloudmail)")
                        
                            .font(.title3)
                            .fontWeight(.bold)
                    } else {
                        Text("Error")
                    }
                } else {
                    Text("Done")
                }
                
             
                
                ProgressView(value: progress)
                    .padding()

                Button(action: {
                    buttonAllowed = false
                    goneWrong = false
                    
                    cookiesPython.run(
                        startValue: selectedList[currentStep] + 1,
                        iterationValue: selectedList[currentStep] + 1,
                        chillValue: waitingTime,
                        headlessValue: "False"
                    ) { success, output, error in
                        if success {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                buttonAllowed = true
                                print("success")
                               
                                
                          
                              
                               
                                    
                                    
                                    
                                    
                                
                                
                                if currentStep - 1 < selectedList.count && !goneWrong == true{
                                    
                                    if accountLoader.accounts[selectedList[currentStep - 1]].cookies == "y"{
                                        
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
                                    print("Edited Account \(dateSave)")
                                    
                                }else{
                                    print("Couldnt edit Account")
                                }

                                
                               
                              
                                    
                                 
                                     

                            }
                            if currentStep < totalSteps {
                                currentStep += 1
                            }
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
                
                if goneWrong {
                    Text("Something seems to have gone wrong. Try again or go to the next account.")
                    Text("Tipp: if it instantly doesnt work on the first try, try quiting all chrome broswer sessions and try again")
                }
                if !buttonAllowed {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                        .scaleEffect(1.0, anchor: .center)
                }
                
                
                //TRY AGAIN
                
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
                        headlessValue: "False"
                    ) { success, output, error in
                        if success {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                buttonAllowed = true
                                
                                
                                if currentStep - 1 < selectedList.count && !goneWrong == true{
                                    
                                    if accountLoader.accounts[selectedList[currentStep - 1]].cookies == "y"{
                                        
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
                                    print("Edited Account \(dateSave)")
                                    
                                }else{
                                    print("Couldnt edit Account")
                                }
                                
                                
                                
                                
                            
                            }
                            
                            if currentStep < totalSteps {
                                currentStep += 1}
                                
                            
                            
                            
                        
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
            Text("Tip: The date when the cookies are going to expire is only updated if the accounts cookies are ❌")
        }
        
        Divider()
        HStack{
            Button(action: {
                OpenHelpWindow.open(selectedPage: "Set up Cookies")
                
            }) {
                Image(systemName: "questionmark.circle.fill")
                    .font(.system(.title2))
                    .foregroundColor(.gray)
                    
                    
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.top,1)
            .padding([.leading,.trailing,.bottom],10)
            
            Spacer()
            if developerSettings == true {
                Text("Details: WaitingTime: \(waitingTime) Division: \(currentStep)/\(totalSteps) ButtonAllowed: \(buttonAllowed) goneWrong: \(goneWrong), dateSave: \(dateSave)")
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Button(action: {
                showSheet = false
            }) {
                Text("Close")
                    .padding(5) // Add padding around the text
            }
            
            
            
            
            
           
          

            .cornerRadius(5)
            
            .padding(.top,1)
            .padding([.leading,.trailing,.bottom],10)
        }.frame(width:1000)
        
    }

       
}
    
#Preview{
    @Previewable @StateObject var accountLoader = AccountLoader()
    @Previewable @State var list: [Int] = [0,1,8,9]
    @Previewable @State var waitingTime = 10
    CookiesSheetView(showSheet:.constant(true),selectedList: $list,waitingTime: $waitingTime)
        .environmentObject(accountLoader)
}
