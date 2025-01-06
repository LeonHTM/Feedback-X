import Foundation

struct CookiesPython {
    let scriptPath: String
    let pythonPath: String = "/Users/leon/Desktop/Feedback-X/feedbackenv/bin/python3"
    
    func run(
        start_value: Int,
        iteration_value: Int,
        chill_value: Int,
        headless_value: String,
        completion: @escaping (Bool, String?, Error?) -> Void
    ) {
        guard !scriptPath.isEmpty else {
            print("Error: scriptPath cannot be empty.")
            completion(false, "Script path is empty.", NSError(domain: "PythonScriptRunner", code: 1, userInfo: nil))
            return
        }
        
        // Create the Process instance
        let process = Process()
        process.executableURL = URL(fileURLWithPath: pythonPath)
        
        // Set up arguments for the Python script
        let arguments = [
            "--start_value", "\(start_value)",
            "--iteration_value", "\(iteration_value)",
            "--chill_value", "\(chill_value)",
            "--headless_value", headless_value
        ]
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
                
                // Capture the output if needed
                let outputData = pipe.fileHandleForReading.readDataToEndOfFile()
                if let outputString = String(data: outputData, encoding: .utf8) {
                    print("Python script output: \(outputString)")
                    
                    // If the process fails, we assume there's an error message in output
                    if process.terminationStatus != 0 {
                        // Return output as an error message if the script fails
                        completion(false, outputString, nil)
                    } else {
                        // If the script succeeds, return no error and an empty message
                        completion(true, nil, nil)
                    }
                }
            } catch {
                print("Error running Python script: \(error.localizedDescription)")
                completion(false, error.localizedDescription, error)
            }
        }
    }
}
