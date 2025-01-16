//
//  CookiesPython.swift
//  Feedback X
//
//  Created by Leon on 16.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//



import Foundation

class CookiesPython: ObservableObject {
    let scriptPath: String
    let pythonPath: String
    private var process: Process?
    
    @Published var isRunning: Bool = false
    @Published var output: String = ""
    
    init(scriptPath: String, pythonPath: String = "/Users/leon/Desktop/Feedback-X/feedbackenv/bin/python3") {
        self.scriptPath = scriptPath
        self.pythonPath = pythonPath
    }
    
    func run(
        startValue: Int,
        iterationValue: Int,
        chillValue: Int,
        headlessValue: String,
        completion: @escaping (Bool, String?, Error?) -> Void
    ) {
        guard !scriptPath.isEmpty else {
            print("Error: scriptPath cannot be empty.")
            completion(false, "Script path is empty.", NSError(domain: "PythonScriptRunner", code: 1, userInfo: nil))
            return
        }
        
        let process = Process()
        self.process = process
        process.executableURL = URL(fileURLWithPath: pythonPath)
        
        let arguments = [
            "--start_value", "\(startValue)",
            "--iteration_value", "\(iterationValue)",
            "--chill_value", "\(chillValue)",
            "--headless_value", headlessValue
        ]
        process.arguments = [scriptPath] + arguments
        
        let pipe = Pipe()
        process.standardOutput = pipe
        process.standardError = pipe
        
        isRunning = true
        
        DispatchQueue.global(qos: .background).async {
            do {
                try process.run()
                process.waitUntilExit()
                self.isRunning = false
                
                let outputData = pipe.fileHandleForReading.readDataToEndOfFile()
                if let outputString = String(data: outputData, encoding: .utf8) {
                    self.output = outputString
                    print("\(outputString)")
                    
                    if process.terminationStatus != 0 {
                        completion(false, outputString, nil)
                    } else {
                        completion(true, outputString, nil)
                    }
                }
            } catch {
                self.isRunning = false
                print("Error running Python script: \(error.localizedDescription)")
                completion(false, error.localizedDescription, error)
            }
        }
    }
    
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


