//
//  runPythonScript.swift
//  Feedback X
//
//  Created by Leon  on 13.12.2024.
//

import Foundation

var isRunning = false

func runPythonScript() {
    let pythonPath = "/Users/leon/Desktop/Feedback-X/feedbackenv/bin/python3"
    let scriptPath = "/Users/leon/Desktop/Feedback-X/python/code/main.py"
    
    // Set isRunning to true before starting the script
    isRunning = true
    
    // Create the Process instance to run the Python script
    let process = Process()
    process.executableURL = URL(fileURLWithPath: pythonPath)
    process.arguments = [scriptPath]
    
    // Set up a pipe to capture the output
    let pipe = Pipe()
    process.standardOutput = pipe
    process.standardError = pipe
    
    DispatchQueue.global(qos: .background).async {
        do {
            // Run the process
            try process.run()
            process.waitUntilExit()
            
            // Capture the output if needed
            let outputData = pipe.fileHandleForReading.readDataToEndOfFile()
            if let outputString = String(data: outputData, encoding: .utf8) {
                print("Python script output: \(outputString)")
            }
        } catch {
            print("Error running Python script: \(error.localizedDescription)")
        }
        
        // Set isRunning to false after the script finishes
        DispatchQueue.main.async {
            isRunning = false
        }
    }
}
