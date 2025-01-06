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
    @State private var step: Double = 0
    @State private var buttonAllowed: Bool = true
    @State private var goneWrong: Bool = false
    
    @Binding var showSheet: Bool
    @Binding var selectedList: [Int]
    @Binding var waitingTime: Int
    
    let cookies = CookiesPython(scriptPath: "/Users/leon/Desktop/Feedback-X/python/code/main_cookies.py")
    

    var body: some View {
        ScrollView {
            
            VStack(alignment: .center, spacing: 15) {
                
                if Int(progress * Double(selectedList.count)+1) <= (selectedList.count) {
                    
                    
                    Text("Account \(Int(progress * Double(selectedList.count)+1)) of \(selectedList.count)")
                        .font(.title)
                        .fontWeight(.bold)
                }else{
                    
                    Text("All done")
                        .font(.title)
                        .fontWeight(.bold)
                }

                if Int(progress * Double(selectedList.count)) < selectedList.count {
                    if !accountLoader.accounts.isEmpty {
                        VStack{
                            Text("Current Account:")
                            Text("\(accountLoader.accounts[selectedList[Int(progress * Double(selectedList.count))]].icloudmail)")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                    } else {
                        Text("No accounts available")
                    }
                }
             
                
                ProgressView(value: progress)
                Text("\(String(progress*100))%")
                    .padding(.top,-20)
                
                
                
                Button(action:{
                    
                    buttonAllowed.toggle()
                    goneWrong = false
                    
                    cookies.run(
                        start_value: selectedList[Int(progress * Double(selectedList.count))] + 1,
                        iteration_value: selectedList[Int(progress * Double(selectedList.count))] + 1,
                        chill_value: waitingTime,
                        headless_value: "False" // Pass "True" or "False" as a string
                    ) { success, output, error in
                        if success {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                buttonAllowed = true
                            }
                            if progress < 1.0{
                                progress += step}
                        } else if let error = error {
                            print("Script execution failed with error: \(error.localizedDescription)")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                buttonAllowed = true
                            }
                            goneWrong = true
                            if progress < 1.0{
                                progress += step}
                            
                        } else if let output = output {
                            print("\(output)")
                            if output.contains("Failed"){
                                goneWrong = true
                                print("\(String(goneWrong))")
                                
                            }
                        }
                    }
                    
                    
                                                            
                                                      
                    
                    
                    
                    
                    
                    
                    
                    
                }){
                    
                    if Int(progress * Double(selectedList.count)) < selectedList.count {
                        if !accountLoader.accounts.isEmpty {
                            Text("Enable Cookies for \(accountLoader.accounts[selectedList[Int(progress * Double(selectedList.count))]].icloudmail)")
                        } else {
                            Text("Error")
                        }
                    }else{
                        Text("Done")
                    }
                }.disabled(progress >= 1.0 || buttonAllowed == false)
                
        
                
                if goneWrong == true{
                    Text("Something seems to have gone wrong. Try again or go to the next account.")
                }
                
                Button(action:{
                    
                    if progress <= 1.0{
                        progress -= step}
                    
                    
                    buttonAllowed.toggle()
                    goneWrong = false
                    
                    cookies.run(
                        start_value: selectedList[Int(progress * Double(selectedList.count))] + 1,
                        iteration_value: selectedList[Int(progress * Double(selectedList.count))] + 1,
                        chill_value: waitingTime,
                        headless_value: "False" // Pass "True" or "False" as a string
                    ) { success, output, error in
                        if success {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                buttonAllowed = true
                            }
                            if progress < 1.0{
                                progress += step}
                        } else if let error = error {
                            print("Script execution failed with error: \(error.localizedDescription)")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                buttonAllowed = true
                            }
                            
                            goneWrong = true
                            if progress < 1.0{
                                progress += step}
                        } else if let output = output {
                            print("\(output)")
                            if output.contains("Failed"){
                                goneWrong = true
                                
                            }
                        }
                    }
                    
                    
                    
                    
                }){
                    
                    
                    
                    
                    
                    Text("Try Again")
                }.disabled(progress > 1.0 || buttonAllowed == false || progress < step)
                
                
                   
                Text("Details: t \(String(waitingTime)), p \(String(progress)), b \(String(buttonAllowed)), g \(String(goneWrong)) ")
                
            }
            .padding()

        }.onAppear {
            accountLoader.loadAccounts(from: accountURL)
            selectedList.sort()
            step  = 1.0 / Double(selectedList.count)
            
            
            
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
    @Previewable @State var list: [Int] = [0,1,8,9]
    @Previewable @State var waitingTime = 10
    CookiesSheetView(showSheet:.constant(true),selectedList: $list,waitingTime: $waitingTime)
        .environmentObject(accountLoader)
}
