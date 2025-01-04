//
//  CookiesView.swift
//  Feedback X
//
//  Created by Leon  on 04.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import SwiftUI

struct CookiesView: View {
    @State public var showHelpSheet = false
    @EnvironmentObject var accountLoader: AccountLoader
    @State private var accountURL = URL(fileURLWithPath: "/Users/leon/Desktop/Feedback-X/python/accounts/accounts.json")
    @State private var isEditing: Bool = false
    @State private var waitingTime = 50.0
    @State private var extraWaiting:Bool = false
    @State private var maxSlider: Double = 60
    @State private var stepSlider:Double = 5
    @State private var buttonActive: Bool = false
    var body: some View {
        VStack(spacing: 0) { // Wrap the entire layout
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Select accounts you want to save cookies for")
                        .font(.title3)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical)
                    ForEach(accountLoader.accounts.indices, id: \.self) { index in
                        let account = accountLoader.accounts[index]
                        HStack{
                            Button(action:{
                                
                                buttonActive.toggle()
                            }){
                                Image(systemName: "circle")
                                    .font(.system(size: 20,weight:.thin))
                            }
                            .buttonStyle(PlainButtonStyle())
                            .background(buttonActive ? Color.accentColor : nil)
                            .foregroundStyle(buttonActive ? Color.accentColor : Color.primary)
                            .clipShape(Circle())
                            
                           
                            VStack(alignment:.leading){
                                Text(account.icloudmail)
                                    .padding(.horizontal)
                                    .fontWeight(.bold)
                                if account.cookies == "y"{
                                    Text("Cookies already set up: ✅")
                                        .padding(.horizontal)
                                        .padding(.vertical,1)
                                    
                                }else{
                                    Text("Cookies already set up: ")
                                        .padding(.horizontal)
                                        .padding(.vertical,1)
                                }
                            }
                            
                            
                        }
                        if index != accountLoader.accounts.count-1{
                            Divider()
                            
                        }
                        
                        
                        
                    }
                    
                    Text("Details")
                        .font(.title3)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    Text("Please use the question mark at the bottom left if you are not sure what you are doing or if you dont understand why this step is necessary and how it performed.")
                    Text("How much waiting time would you like to have. In this time you will recieve an SMS with a 6 digit code from Apple and you will have to enter it in the app.")
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
                        Text("You will have \(Int(waitingTime)) seconds.")
                            .foregroundColor(isEditing ? .red : .primary)
                    
                    Toggle(isOn: $extraWaiting) {
                        Text("More time")
                    }.onChange(of: extraWaiting) {
                        if extraWaiting == true{
                            maxSlider = 300
                            stepSlider = 10

                        }else{
                            maxSlider = 60
                            stepSlider = 5
                        }
                    }
                            
                    
                    
                }
                .padding(.horizontal,5)
                .frame(maxWidth: .infinity)
                
            }.onAppear {
                accountLoader.loadAccounts(from: accountURL)
            }
            
            Divider()
            
            HStack {
                Button(action: {
                    showHelpSheet = true
                }) {
                    Image(systemName: "questionmark.circle.fill")
                        .font(.system(.title2))
                        .foregroundColor(.gray)
                }
                .buttonStyle(PlainButtonStyle())
                .padding([.leading, .trailing, .bottom], 5)
                .sheet(isPresented: $showHelpSheet) {
                    HelpMeView()
                        .frame(minWidth: 1100, minHeight: 750)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
        .frame(width: 1000) // Ensures consistent parent view width
    }
}

#Preview {
    @Previewable @StateObject var accountLoader = AccountLoader()
    CookiesView().environmentObject(accountLoader)
}
