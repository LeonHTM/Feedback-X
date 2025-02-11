//
//  CookiesChecker.swift
//  Feedback X
//
//  Created by Leon on 20.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import Foundation

struct CookiesCheck {
    static func check(iterations: Int, accountURL: URL, completion: @escaping (Bool) -> Void) {
        // Instantiate AccountLoader
        let accountLoader = AccountLoader()
        
        // Load accounts from the given URL
        accountLoader.loadAccounts(from: accountURL)
        
        // Ensure accounts are loaded
        guard !accountLoader.accounts.isEmpty else {
            print("No accounts found. Exiting check.")
            completion(false)
            return
        }
        
        // Ensure iterations do not exceed the number of accounts
        let validIterations = min(iterations, accountLoader.accounts.count)
        
        // Perform checks
        for iteration in 0..<validIterations {
            print("Checking iteration: \(iteration)")
            let currentAccount = accountLoader.accounts[iteration]
            
            if currentAccount.cookies != "y" {
                completion(false)
                return // Exit early once a failure is found
            }
        }
        
        // If all accounts pass the check
        completion(true)
    }
}
