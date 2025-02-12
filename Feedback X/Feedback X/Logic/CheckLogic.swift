//
//  CheckLogic.swift
//  Feedback X
//
//  Created by Leon  on 04.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import Foundation
import SwiftUI


//Check if Application is Online, by contacting Google.com
struct OnlineCheck {
    static func checkGoogle(completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "https://google.com") else {
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "HEAD"
        
        URLSession(configuration: .default)
            .dataTask(with: request) { (_, response, error) in
                if let error = error {
                    print("Error:", error)
                    completion(false)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    completion(true)
                } else {
                    completion(false)
                }
            }
            .resume()
    }
}


//Get Application Version and Builnd
struct VersionBuild {
    static func getAppVersion() -> String {
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
          
            return appVersion
        }
        return "Unknown"
    }
    
    static func getBuildNumber() -> String {
        if let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
        
            return buildNumber
        }
        return "Unknown"
    }
}

//Check if all Account have valid Cookies
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

//Get Color for a Double Value
public struct ColorForWaitingTime {
    static func colorMatch(_ time: Double, maxTime: Double = 100) -> Color {
        let clampedTime = max(20, min(maxTime, time)) // Clamp time to the range 20...maxTime
        let progress = (clampedTime - 20) / (maxTime - 20) // Normalize to 0.0 (20) to 1.0 (maxTime)

        // Transition logic
        let red: Double
        let green: Double

        if progress <= 0.5 {
            // Transition from Red to Yellow (0.0 to 0.5)
            red = 1.0
            green = 2 * progress
        } else {
            // Transition from Yellow to Green (0.5 to 1.0)
            red = 2 * (1.0 - progress)
            green = 1.0
        }

        return Color(red: red, green: green, blue: 0.0)
    }
}
