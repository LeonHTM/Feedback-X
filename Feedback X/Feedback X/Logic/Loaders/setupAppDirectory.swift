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
    
    // New "Feedback env" folder
    let feedbackEnvDir = appFolder.appendingPathComponent("Feedbackenv")
    let feedbackEnvBinDir = feedbackEnvDir.appendingPathComponent("bin")
    let feedbackEnvPythonDir = feedbackEnvBinDir.appendingPathComponent("python3")
    
    let PythonDir = appFolder.appendingPathComponent("Python")
    
    let mainPythonDir = PythonDir.appendingPathComponent("main.py")
    let cookiesPythonDir = PythonDir.appendingPathComponent("main_cookies.py")

    do {
        // Create "Feedback X" folder if it doesn't exist
        if !fileManager.fileExists(atPath: appFolder.path) {
            try fileManager.createDirectory(at: appFolder, withIntermediateDirectories: true, attributes: nil)
            print("Created Feedback X directory.")
        }
        
        // Create "saves" directory
        if !fileManager.fileExists(atPath: savesDir.path) {
            try fileManager.createDirectory(at: savesDir, withIntermediateDirectories: true, attributes: nil)
            print("Created saves directory.")
        }
        
        // Create "accounts" directory
        if !fileManager.fileExists(atPath: accountsDir.path) {
            try fileManager.createDirectory(at: accountsDir, withIntermediateDirectories: true, attributes: nil)
            print("Created accounts directory.")
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
            print("Created current_fdb directory.")
        }
        
        // Create "cookies" directory
        if !fileManager.fileExists(atPath: cookiesFolderDir.path) {
            try fileManager.createDirectory(at: cookiesFolderDir, withIntermediateDirectories: true, attributes: nil)
            print("Created cookies directory.")
        }
        
        // Create "content.txt"
        if !fileManager.fileExists(atPath: contentFile.path) {
            fileManager.createFile(atPath: contentFile.path, contents: nil, attributes: nil)
        }

        // Create "Feedback env" directory
        if !fileManager.fileExists(atPath: feedbackEnvDir.path) {
            try fileManager.createDirectory(at: feedbackEnvDir, withIntermediateDirectories: true, attributes: nil)
            UserDefaults.standard.set(feedbackEnvDir.path, forKey: "feedbackEnvPath")
            moveFeedbackEnvFilesToSandbox()
            print("Created Feedbackenv directory.")
        }
        
        
        if !fileManager.fileExists(atPath: PythonDir.path) {
            try fileManager.createDirectory(at: PythonDir, withIntermediateDirectories: true, attributes: nil)
            UserDefaults.standard.set(PythonDir.path, forKey: "PythonPath") 
            movePythonToSandbox()
            print("Created Python directory.")
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

func moveFeedbackEnvFilesToSandbox() {
    let fileManager = FileManager.default
    
    // Get the path for "Feedback env" in the app bundle (where it was previously located)
    guard let bundleFeedbackEnvPath = Bundle.main.path(forResource: "Feedbackenv", ofType: "")  else {
        print("Feedback env folder not found in the app bundle.")
        return
    }
    
    guard let sandboxFeedbackEnvDir = UserDefaults.standard.string(forKey: "feedbackEnvPath") else {
            print("Sandbox path for Feedback env is missing.")
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
                    print("Copied \(item.lastPathComponent) to sandbox Feedback env directory.")
                }
            }
    } catch {
        print("Error moving files to Feedback env folder: \(error)")
    }
}



func movePythonToSandbox() {
    let fileManager = FileManager.default
    
    // Get the path for "Feedback env" in the app bundle (where it was previously located)
    guard let bundlePythonPath = Bundle.main.path(forResource: "Python", ofType: "") else {
        print("Python folder not found in the app bundle.")
        return
    }
    
    // Retrieve the sandbox path from UserDefaults
    guard let sandboxPythonDir = UserDefaults.standard.string(forKey: "PythonPath") else {
        print("Sandbox path for Python is missing.")
        return
    }
    
    // Get the full source and destination paths
    let sourceURL = URL(fileURLWithPath: bundlePythonPath)
    let destinationURL = URL(fileURLWithPath: sandboxPythonDir)
    
    do {
        // Check if the source is a directory, if so, get the list of items inside
        var isDirectory: ObjCBool = false
        if fileManager.fileExists(atPath: sourceURL.path, isDirectory: &isDirectory), isDirectory.boolValue {
            // Copy directory contents if it's a directory
            let items = try fileManager.contentsOfDirectory(at: sourceURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            for item in items {
                let destinationItem = destinationURL.appendingPathComponent(item.lastPathComponent)
                if !fileManager.fileExists(atPath: destinationItem.path) {
                    try fileManager.copyItem(at: item, to: destinationItem)
                    print("Copied \(item.lastPathComponent) to sandbox Feedback env directory.")
                }
            }
        } else {
            // If it's a file, copy it directly
            let destinationFile = destinationURL.appendingPathComponent(sourceURL.lastPathComponent)
            if !fileManager.fileExists(atPath: destinationFile.path) {
                try fileManager.copyItem(at: sourceURL, to: destinationFile)
                print("Copied file \(sourceURL.lastPathComponent) to sandbox Feedback env directory.")
            }
        }
    } catch {
        print("Error moving files to Feedback env folder: \(error)")
    }
}
