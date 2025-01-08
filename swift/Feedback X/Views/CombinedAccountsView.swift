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





    
