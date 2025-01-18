//
//  FeedbackPython.swift
//  Feedback X
//
//  Created by Leon on 16.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import Foundation

class FeedbackPython: ObservableObject {
    let scriptPath: String
    let pythonPath: String = "/Users/leon/Desktop/Feedback-X/feedbackenv/bin/python3"
    
    // Published properties for observing changes
    @Published var isRunning: Bool = false
    @Published var output: String? = nil

    // Shared variable to keep track of the running process
    private var process: Process?

    init(scriptPath: String) {
        self.scriptPath = scriptPath
    }

    func run(
        startValue: Int,
        iterationValue: Int,
        submitValue: String,
        titleValue: String,
        pathValue: String,
        headlessValue: Bool,
        uploadValue: [String],
        topicValue: String,
        completion: @escaping (Bool, String?, Error?) -> Void
    ) {
        guard !scriptPath.isEmpty else {
            completion(false, nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "scriptPath cannot be empty"]))
            return
        }

        guard FileManager.default.fileExists(atPath: pythonPath) else {
            completion(false, nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Python executable not found at \(pythonPath)"]))
            return
        }

        guard FileManager.default.fileExists(atPath: scriptPath) else {
            completion(false, nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Script file not found at \(scriptPath)"]))
            return
        }

        let process = Process()
        process.executableURL = URL(fileURLWithPath: pythonPath)

        // Ensure unbuffered output by adding the `-u` flag
        let headlessString = headlessValue ? "True" : "False"
        var arguments = [
            "-u", // Unbuffered output flag
            scriptPath,
            "--start_value", "\(startValue)",
            "--iteration_value", "\(iterationValue)",
            "--submit_value", submitValue,
            "--title_value", titleValue,
            "--path_value", pathValue,
            "--headless_value", headlessString,
            "--topic_value", topicValue
        ]
        
        // Append upload values as arguments
        for upload in uploadValue {
            arguments.append("--upload_value")
            arguments.append(upload)
        }

        process.arguments = arguments

        let pipe = Pipe()
        process.standardOutput = pipe
        process.standardError = pipe

        self.process = process
        self.isRunning = true

        DispatchQueue.global(qos: .background).async {
            let handle = pipe.fileHandleForReading
            handle.readabilityHandler = { fileHandle in
                if let line = String(data: fileHandle.availableData, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines), !line.isEmpty {
                    DispatchQueue.main.async {
                        self.output = line // Always update with the most recent line
                        print(line) // Log to Xcode console only if the line is not empty
                    }
                }
            }

            
            do {
                try process.run()
                
                // Wait until the process finishes, and then call completion
                process.waitUntilExit()
                
                // Ensure we stop reading output when the process completes
                handle.readabilityHandler = nil
                
                // After the process completes, handle the success case
                DispatchQueue.main.async {
                    self.isRunning = false
                    self.process = nil
                    if process.terminationStatus == 0 {
                        // Process completed successfully
                        completion(true, self.output, nil)
                    } else {
                        // Process failed with non-zero exit code
                        completion(false, self.output, NSError(domain: "", code: Int(process.terminationStatus), userInfo: [NSLocalizedDescriptionKey: "Process failed with exit code \(process.terminationStatus)"]))
                    }
                }
                
            } catch {
                DispatchQueue.main.async {
                    self.isRunning = false
                    self.output = nil
                    self.process = nil
                    completion(false, nil, error)
                }
            }
        }
    }

    // Function to terminate the running Python process
    func stop() {
        if let process = self.process, process.isRunning {
            process.terminate() // Terminates the process gracefully
            print("Python script terminated.")
            DispatchQueue.main.async {
                self.isRunning = false // Update state to indicate the process has stopped
                self.process = nil
            }
        }
    }
}

