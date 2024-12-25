//
//  AccountLoader.swift
//  Feedback X
//
//  Created by Leon  on 25.12.2024.
//  Copyright © 2024 LeonHTM. All rights reserved.
//

import Foundation

func AccountLoader(from path: String) -> [(relay: String, account: String, password: String, country: String, icloudmail: String, appledev: String, cookies: String)] {
    var results: [(relay: String, account: String, password: String, country: String, icloudmail: String, appledev: String, cookies: String)] = []

    do {
        // Read the contents of the file
        let fileContents = try String(contentsOfFile: path, encoding: .utf8)
        
        // Split into lines
        let lines = fileContents.split(separator: "\n")
        
        for line in lines {
            // Parse each line as JSON
            if let data = line.data(using: .utf8),
               let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                
                // Extract the fields from the JSON object
                if let relay = jsonObject["relay"] as? String,
                   let account = jsonObject["account"] as? String,
                   let password = jsonObject["password"] as? String,
                   let country = jsonObject["country"] as? String,
                   let icloudmail = jsonObject["icloudmail"] as? String,
                   let appledev = jsonObject["appledev"] as? String,
                   let cookies = jsonObject["cookies"] as? String {
                    
                    // Append the extracted data as a tuple
                    let accountInfo: (String, String, String, String, String, String, String) = (
                        relay,
                        account,
                        password,
                        country,
                        icloudmail,
                        appledev,
                        cookies
                    )
                    
                    results.append(accountInfo)
                }
            }
        }
        
        return results
    } catch {
        print("Error reading or parsing file: \(error)")
        return []
    }
}



