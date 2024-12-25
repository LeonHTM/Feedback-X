//
//  AccountLoader.swift
//  Feedback X
//
//  Created by Leon  on 25.12.2024.
//  Copyright © 2024 LeonHTM. All rights reserved.
//

import Foundation

struct AccountLoader {
    static func loadAccounts(from path: String) -> [(relay: String, account: String, password: String, country: String, icloudmail: String, appledev: String, cookies: String)] {
        var results: [(relay: String, account: String, password: String, country: String, icloudmail: String, appledev: String, cookies: String)] = []
        
        do {
            let fileContents = try String(contentsOfFile: path, encoding: .utf8)
            let lines = fileContents.split(separator: "\n")
            
            for line in lines {
                if let data = line.data(using: .utf8),
                   let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    
                    if let relay = jsonObject["relay"] as? String,
                       let account = jsonObject["account"] as? String,
                       let password = jsonObject["password"] as? String,
                       let country = jsonObject["country"] as? String,
                       let icloudmail = jsonObject["icloudmail"] as? String,
                       let appledev = jsonObject["appledev"] as? String,
                       let cookies = jsonObject["cookies"] as? String {
                        
                        results.append((relay, account, password, country, icloudmail, appledev, cookies))
                    }
                }
            }
            return results
        } catch {
            print("Error reading or parsing file: \(error)")
            return []
        }
    }

    static func editAccounts(
        path: String,
        relay: String,
        account: String,
        password: String,
        country: String,
        icloudmail: String,
        appledev: String,
        cookies: String,
        index: Int
    ) {
        // Load existing accounts
        var accounts = loadAccounts(from: path)
        
        // Ensure the index is valid
        guard index >= 0 && index < accounts.count else {
            print("Invalid index")
            return
        }
        
        // Update the account at the specified index
        accounts[index] = (relay, account, password, country, icloudmail, appledev, cookies)
        
        // Write updated accounts back to the file
        do {
            let updatedData = accounts.map { account in
                [
                    "relay": account.relay,
                    "account": account.account,
                    "password": account.password,
                    "country": account.country,
                    "icloudmail": account.icloudmail,
                    "appledev": account.appledev,
                    "cookies": account.cookies
                ]
            }
            
            let jsonData = try updatedData.map {
                try JSONSerialization.data(withJSONObject: $0, options: [])
            }.map { String(data: $0, encoding: .utf8)! }
            
            let updatedFileContent = jsonData.joined(separator: "\n")
            try updatedFileContent.write(toFile: path, atomically: true, encoding: .utf8)
            
            print("Account updated successfully")
        } catch {
            print("Error writing to file: \(error)")
        }
    }
}



