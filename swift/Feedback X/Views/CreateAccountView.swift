//
//  CreateAccountView.swift
//  Feedback X
//
//  Created by LeonHTM  on 25.12.2024.
//  Copyright © 2024 LeonHTM. All rights reserved.
//

import SwiftUI

struct CreateAccountView: View {
    @State private var isRunning: Bool = false
    @State private var showAlert: Bool = false
    @State private var showSheet = false 
    @EnvironmentObject var accountLoader: AccountLoader
    
    var body: some View {
        VStack {
            Text("No Account Selected")
                .font(.title2)
                .foregroundStyle(Color.secondary)
            
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
        }
    }
}

#Preview {
    CreateAccountView()
}
