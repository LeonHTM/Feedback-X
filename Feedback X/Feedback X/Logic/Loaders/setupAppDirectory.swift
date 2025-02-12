//
//  setupAppDirectory.swift
//  Feedback X
//
//  Created by Leon  on 11.02.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import Foundation

func setupAppDirectories() {
    let fileManager = FileManager.default
    
    // Get the Application Support directory
    guard let appSupportDir = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
        print("Failed to find Application Support directory.")
        return
    }
    
    let appFolder = appSupportDir.appendingPathComponent("Feedback X")
    
    let savesDir = appFolder.appendingPathComponent("saves")
    let savesFile = savesDir.appendingPathComponent("example.txt")
    
    let accountsDir = appFolder.appendingPathComponent("accounts")
    let accountsFile = accountsDir.appendingPathComponent("accounts.json")
    
    let currentfdbDir = appFolder.appendingPathComponent("current_fdb")
    let contentFile = currentfdbDir.appendingPathComponent("content.txt")
    
    
    let cookiesFolderDir = appFolder.appendingPathComponent("cookies")
    
    do {
        // Create "Feedback X" folder if it doesn't exist
        if !fileManager.fileExists(atPath: appFolder.path) {
            try fileManager.createDirectory(at: appFolder, withIntermediateDirectories: true, attributes: nil)
            print("Created Feedback X directory.")
        }
        
        // Create "saves" directory if it doesn't exist
        if !fileManager.fileExists(atPath: savesDir.path) {
            try fileManager.createDirectory(at: savesDir, withIntermediateDirectories: true, attributes: nil)
            print("Created saves directory.")
        }
        
        // Create "accounts" directory if it doesn't exist
        if !fileManager.fileExists(atPath: accountsDir.path) {
            try fileManager.createDirectory(at: accountsDir, withIntermediateDirectories: true, attributes: nil)
            print("Created accounts directory.")
        }
        
        // Create an empty accounts.json file with an empty array if it doesn't exist
        if !fileManager.fileExists(atPath: accountsFile.path) {
            let emptyArray = "[]".data(using: .utf8) // Empty array JSON
            fileManager.createFile(atPath: accountsFile.path, contents: emptyArray, attributes: nil)
            print("Created accounts.json with empty array.")
        }
        
        // Create an empty example.txt
        if !fileManager.fileExists(atPath: savesFile.path) {
            fileManager.createFile(atPath: savesFile.path, contents: nil, attributes: nil)
            
        }
        
        // Create "current_fdb" directory if it doesn't exist
        if !fileManager.fileExists(atPath: currentfdbDir.path) {
            try fileManager.createDirectory(at: currentfdbDir, withIntermediateDirectories: true, attributes: nil)
            print("Created saves directory.")
        }
        
        // Create "cookies" directory if it doesn't exist
        if !fileManager.fileExists(atPath: cookiesFolderDir.path) {
            try fileManager.createDirectory(at: cookiesFolderDir, withIntermediateDirectories: true, attributes: nil)
            print("Created saves directory.")
        }
        
        // Create empty content.txt
        if !fileManager.fileExists(atPath: contentFile.path) {
            fileManager.createFile(atPath: contentFile.path, contents: nil, attributes: nil)
            
        }
        
        
       
        UserDefaults.standard.set(savesDir.path, forKey: "savesPath")
        UserDefaults.standard.set(accountsFile.path, forKey: "accountsPath")
        UserDefaults.standard.set(cookiesFolderDir.path, forKey: "cookiesFolderPath")
        UserDefaults.standard.set(currentfdbDir.path, forKey: "currentfdbPath")
        UserDefaults.standard.set(contentFile.path, forKey: "contentPath")
            
        
        
    } catch {
        print("Error setting up app directories: \(error)")
    }
}
