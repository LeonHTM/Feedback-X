//
//  FeedbackPython.swift
//  Feedback X
//
//  Created by Leon  on 16.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import Foundation

struct FeedbackPython {
    let scriptPath: String
    let pythonPath: String = "/Users/leon/Desktop/Feedback-X/feedbackenv/bin/python3"
    
    func run(
        startValue: Int,
        iterationValue: Int,
        submitValue: String,
        titleValue: String,
        pathValue: String,
        headlessValue: Bool,
        uploadValue: [String],
        areaValue: String,
        completion: @escaping (Bool, String?, Error?) -> Void
    ) {
        guard !scriptPath.isEmpty else {
            print("Error: scriptPath cannot be empty.")
            completion(false, "Script path is empty.", NSError(domain: "FeedbackPython", code: 1, userInfo: nil))
            return
        }
        
        // Create the Process instance
        let process = Process()
        process.executableURL = URL(fileURLWithPath: pythonPath)
        
        // Convert `headlessValue` to a string representation
        let headlessString = headlessValue ? "True" : "False"
        
        // Set up arguments for the Python script
        var arguments = [
            "--start_value", "\(startValue)",
            "--iteration_value", "\(iterationValue)",
            "--submit_value", submitValue,
            "--title_value", titleValue,
            "--path_value", pathValue,
            "--headless_value", headlessString,
            "--area_value", areaValue
        ]
        
        // Add upload values as multiple arguments
        for upload in uploadValue {
            arguments.append("--upload_value")
            arguments.append(upload)
        }
        
        process.arguments = [scriptPath] + arguments
        
        // Set up a pipe to capture the output (both stdout and stderr)
        let pipe = Pipe()
        process.standardOutput = pipe
        process.standardError = pipe
        
        DispatchQueue.global(qos: .background).async {
            do {
                // Run the process
                try process.run()
                process.waitUntilExit()
                
                // Capture the output
                let outputData = pipe.fileHandleForReading.readDataToEndOfFile()
                if let outputString = String(data: outputData, encoding: .utf8) {
                    print("\(outputString)")
                    
                    // If the process fails, we assume there's an error message in output
                    if process.terminationStatus != 0 {
                        completion(false, outputString, nil)
                    } else {
                        completion(true, outputString, nil)
                    }
                }
            } catch {
                print("Error running Python script: \(error.localizedDescription)")
                completion(false, error.localizedDescription, error)
            }
        }
    }
}


