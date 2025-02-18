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
    
    //Create Library Folder "Feedback X"
    let appFolder = appSupportDir.appendingPathComponent("Feedback X")
    
    
    // Create Saves Folder
    let savesDir = appFolder.appendingPathComponent("Saves")
    let savesFile = savesDir.appendingPathComponent("example.txt")
    
    //Create Accounts Folder
    let accountsDir = appFolder.appendingPathComponent("Accounts")
    let accountsFile = accountsDir.appendingPathComponent("accounts.json")
    
    //Create CurrentFDB Folder
    let currentfdbDir = appFolder.appendingPathComponent("CurrentFDB")
    let contentFile = currentfdbDir.appendingPathComponent("content.txt")
    
    //Create Cookies Folder
    let cookiesFolderDir = appFolder.appendingPathComponent("Cookies")
    
    // New "Feedback env" folder
    let feedbackEnvDir = appFolder.appendingPathComponent("Feedbackenv")
    let feedbackEnvBinDir = feedbackEnvDir.appendingPathComponent("bin")
    let feedbackEnvPythonDir = feedbackEnvBinDir.appendingPathComponent("python3")
    
    
    //Create Python Folder
    let PythonDir = appFolder.appendingPathComponent("Python")
    let mainPythonDir = PythonDir.appendingPathComponent("main.py")
    let cookiesPythonDir = PythonDir.appendingPathComponent("main_cookies.py")
    
    //Create Chrome Driver Folder
    let ChromeDir = appFolder.appendingPathComponent("Chrome")
    
    
    

    do {
        // Create "Feedback X" folder if it doesn't exist
        if !fileManager.fileExists(atPath: appFolder.path) {
            try fileManager.createDirectory(at: appFolder, withIntermediateDirectories: true, attributes: nil)
            print("Created Feedback X directory.")
        }
        
        // Create "saves" directory
        if !fileManager.fileExists(atPath: savesDir.path) {
            try fileManager.createDirectory(at: savesDir, withIntermediateDirectories: true, attributes: nil)
            print("Created Saves directory.")
        }
        
        // Create "accounts" directory
        if !fileManager.fileExists(atPath: accountsDir.path) {
            try fileManager.createDirectory(at: accountsDir, withIntermediateDirectories: true, attributes: nil)
            print("Created Accounts directory.")
        }
        
        // Create "accounts.json" with empty array if missing
        if !fileManager.fileExists(atPath: accountsFile.path) {
            let emptyArray = "[]".data(using: .utf8)
            fileManager.createFile(atPath: accountsFile.path, contents: emptyArray, attributes: nil)
            print("Created accounts.json with empty array.")
        }
        
        // Create "example.txt"
        if !fileManager.fileExists(atPath: savesFile.path) {
            fileManager.createFile(atPath: savesFile.path, contents: nil, attributes: nil)
        }
        
        // Create "current_fdb" directory
        if !fileManager.fileExists(atPath: currentfdbDir.path) {
            try fileManager.createDirectory(at: currentfdbDir, withIntermediateDirectories: true, attributes: nil)
            print("Created CurrentFDB directory.")
        }
        
        // Create "cookies" directory
        if !fileManager.fileExists(atPath: cookiesFolderDir.path) {
            try fileManager.createDirectory(at: cookiesFolderDir, withIntermediateDirectories: true, attributes: nil)
            print("Created Cookies directory.")
        }
        
        // Create "content.txt"
        if !fileManager.fileExists(atPath: contentFile.path) {
            fileManager.createFile(atPath: contentFile.path, contents: nil, attributes: nil)
        }

        // Create "Feedback env" directory
        if !fileManager.fileExists(atPath: feedbackEnvDir.path) {
            try fileManager.createDirectory(at: feedbackEnvDir, withIntermediateDirectories: true, attributes: nil)
            UserDefaults.standard.set(feedbackEnvDir.path, forKey: "feedbackEnvPath")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                moveFiles(bundle:"Feedbackenv", destination:"feedbackEnvPath", ofType: "")
            }
            print("Created Feedbackenv directory.")
        }
        
        
        if !fileManager.fileExists(atPath: PythonDir.path) {
            try fileManager.createDirectory(at: PythonDir, withIntermediateDirectories: true, attributes: nil)
            UserDefaults.standard.set(PythonDir.path, forKey: "PythonPath")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                moveFiles(bundle:"Python",destination:"PythonPath", ofType: "")
            }
            print("Created Python directory.")
        }
        
        if !fileManager.fileExists(atPath: ChromeDir.path) {
            try fileManager.createDirectory(at: ChromeDir, withIntermediateDirectories: true, attributes: nil)
            UserDefaults.standard.set(ChromeDir.path, forKey: "ChromePath")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                moveFiles(bundle:"Chrome",destination: "ChromePath", ofType: ".app")
            }
            print("Created Chrome directory.")
        }
        
        

        // Store paths in UserDefaults
        UserDefaults.standard.set(savesDir.path, forKey: "savesPath")
        UserDefaults.standard.set(accountsFile.path, forKey: "accountsPath")
        UserDefaults.standard.set(cookiesFolderDir.path, forKey: "cookiesFolderPath")
        UserDefaults.standard.set(currentfdbDir.path, forKey: "currentfdbPath")
        UserDefaults.standard.set(contentFile.path, forKey: "contentPath")
        
        UserDefaults.standard.set(mainPythonDir.path, forKey: "mainPath")
        UserDefaults.standard.set(cookiesPythonDir.path, forKey: "cookiesPath")
        
        UserDefaults.standard.set(feedbackEnvPythonDir.path, forKey: "feedbackEnvPythonPath")
        
        
    } catch {
        print("Error setting up app directories: \(error)")
    }
}

func moveFiles(bundle: String, destination: String,ofType:String) {
    let fileManager = FileManager.default
    
    // Get the path for "Feedback env" in the app bundle (where it was previously located)
    guard let bundleFeedbackEnvPath = Bundle.main.path(forResource: bundle, ofType: ofType)  else {
        print("\(bundle) folder not found in the app bundle.")
        return
    }
    
    guard let sandboxFeedbackEnvDir = UserDefaults.standard.string(forKey: destination) else {
            print("Sandbox path for \(bundle) is missing.")
            return
        }
        
        // Get the full source and destination paths
        let sourceURL = URL(fileURLWithPath: bundleFeedbackEnvPath)
        let destinationURL = URL(fileURLWithPath: sandboxFeedbackEnvDir)
        
        do {
            // Copy files/folders from the app bundle to the sandbox Feedback env folder
            let items = try fileManager.contentsOfDirectory(at: sourceURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            for item in items {
                let destinationItem = destinationURL.appendingPathComponent(item.lastPathComponent)
                if !fileManager.fileExists(atPath: destinationItem.path) {
                    try fileManager.copyItem(at: item, to: destinationItem)
                    print("Copied \(item.lastPathComponent) to \(destination) directory.")
                }
            }
    } catch {
        print("Error moving files to \(bundle) \(error)")
    }
}




