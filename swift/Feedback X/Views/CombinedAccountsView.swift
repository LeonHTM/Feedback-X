//
//  CombinedAccountsView.swift
//  Feedback X
//
//  Created by LeonHTM on 14.12.2024.
//  Copyright © 2024 LeonHTM. All rights reserved.
//

import SwiftUI

struct CombinedAccountsView: View {
   
    @State private var selectedAccount: Account? = nil
    @State private var selectedIndex: Int? = nil
    @State private var editingMode: Bool = false
    @EnvironmentObject var accountLoader: AccountLoader
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HSplitView {
            RecentAccountsView(selectedAccount: $selectedAccount, selectedIndex: $selectedIndex,editingMode:$editingMode)
                .environmentObject(accountLoader)
                .if(colorScheme == .light){
                                    $0.background(Color.white)
                                }
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
                    },
                    editingMode: $editingMode
                )
                .environmentObject(accountLoader)
                .if(colorScheme == .light){
                                    $0.background(Color.white)
                                }
                .frame(minWidth: 500, maxWidth: 1250)
            } else {
                // Show CreateAccountView if no valid selectedIndex is available
                CreateAccountView()
                    .environmentObject(accountLoader)
                    .if(colorScheme == .light){
                        $0.background(Color.white)
                    }
                    .frame(minWidth: 500, maxWidth: 1250, maxHeight: .infinity)
            }
        }
    }
}





    
