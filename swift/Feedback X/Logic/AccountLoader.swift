//
//  AccountLoader.swift
//  Feedback X
//
//  Created by Leon on 25.12.2024.
//  Copyright © 2024 LeonHTM. All rights reserved.
//

import SwiftUI
import Combine

struct Account: Identifiable, Codable {
    var id: String { account } // Use account as a unique identifier
    var account: String
    var icloudmail: String
    var password: String
    var relay: String
    var country: String
    var appledev: String
    var cookies: String
}

class AccountLoader: ObservableObject {
    @Published var accounts: [Account] = []
    
    // Function to load accounts from a URL
    func loadAccounts(from accountURL: URL) {
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: accountURL.path) {
            do {
                let data = try Data(contentsOf: accountURL)
                let decoder = JSONDecoder()
                self.accounts = try decoder.decode([Account].self, from: data)
            } catch {
                print("Error loading accounts: \(error)")
            }
        } else {
            print("File does not exist at path: \(accountURL.path)")
        }
    }
    
    // Function to edit an account at a specific index
    func editAccount(at index: Int, with updatedAccount: Account, to accountURL: URL) {
        guard index >= 0 && index < accounts.count else { return }
        
        accounts[index] = updatedAccount
        
        // Save the updated accounts array back to the file
        saveAccounts(to: accountURL)
    }
    
    // Function to save the accounts to a URL
    private func saveAccounts(to accountURL: URL) {
        let fileManager = FileManager.default
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(accounts)
            try data.write(to: accountURL)
        } catch {
            print("Error saving accounts: \(error)")
        }
    }
}
