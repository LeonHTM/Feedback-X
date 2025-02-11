//
//  CookiesPython.swift
//  Feedback X
//
//  Created by Leon on 16.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import Foundation

// ObservableObject class to manage running a Python script from Swift
class CookiesPython: ObservableObject {
    // Path to the Python script to be run
    let scriptPath: String
    
    // Path to the Python interpreter to be used
    let pythonPath: String
    
    // Process instance to manage the script execution
    private var process: Process?
    
    // Published properties to update the UI
    @Published var isRunning: Bool = false
    @Published var output: String = ""
    
    //Bundle.main.path(forResource: "python3", ofType: nil, inDirectory: "Feedbackenv/bin")
    
    
    // Initializer to set the script and Python paths
    init(scriptPath: String, pythonPath: String = Bundle.main.path(forResource: "python3", ofType: nil, inDirectory: "Feedbackenv/bin") ?? "fei") {
        self.scriptPath = scriptPath
        self.pythonPath = pythonPath
    }
    
    // Function to run the Python script with the provided arguments
    func run(
        startValue: Int,
        iterationValue: Int,
        chillValue: Int,
        headlessValue: String,
        accounts_file_path: String,
        cookies_file_path: String,
        completion: @escaping (Bool, String?, Error?) -> Void
    ) {
        // Ensure the script path is not empty
        guard !scriptPath.isEmpty else {
            print("Error: scriptPath cannot be empty.")
            completion(false, "Script path is empty.", NSError(domain: "PythonScriptRunner", code: 1, userInfo: nil))
            return
        }
        
        let process = Process()
        self.process = process
        process.executableURL = URL(fileURLWithPath: pythonPath)
        
        // Set the arguments to be passed to the Python script
        let arguments = [
            "--start_value", "\(startValue)",
            "--iteration_value", "\(iterationValue)",
            "--chill_value", "\(chillValue)",
            "--headless_value", headlessValue,
            "--accounts_file_path","\(accounts_file_path)",
            "--cookies_file_path","\(cookies_file_path)"
        ]
        process.arguments = [scriptPath] + arguments
        
        // Create a pipe to capture the script's output
        let pipe = Pipe()
        process.standardOutput = pipe
        process.standardError = pipe
        
        isRunning = true
        
        // Run the process asynchronously
        DispatchQueue.global(qos: .background).async {
            do {
                try process.run()
                process.waitUntilExit()
                self.isRunning = false
                
                // Read the output data from the pipe
                let outputData = pipe.fileHandleForReading.readDataToEndOfFile()
                if let outputString = String(data: outputData, encoding: .utf8) {
                    self.output = outputString
                    print("\(outputString)")
                    
                    // Check the termination status to determine if the script ran successfully
                    if process.terminationStatus != 0 {
                        completion(false, outputString, nil)
                    } else {
                        completion(true, outputString, nil)
                    }
                }
            } catch {
                //self.isRunning = false
                print("Error running Python script: \(error.localizedDescription)")
                completion(false, error.localizedDescription, error)
            }
        }
    }
    
    // Function to stop the running Python script
    func stop() {
        if let process = process, process.isRunning {
            process.terminate()
            isRunning = false
            print("Process terminated.")
        } else {
            print("No process is currently running.")
        }
    }
}
