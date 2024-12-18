import Foundation

var isRunning = false

func runPythonScript(scriptPath: String, completion: @escaping (Bool, String?, Error?) -> Void) {
    let pythonPath = "/Users/leon/Desktop/Feedback-X/feedbackenv/bin/python3"
    
    guard !scriptPath.isEmpty else {
        print("Error: scriptPath cannot be empty.")
        completion(false, "Script path is empty.", NSError(domain: "runPythonScript", code: 1, userInfo: nil))
        return
    }
    
    // Set isRunning to true before starting the script
    isRunning = true
    
    // Create the Process instance to run the Python script
    let process = Process()
    process.executableURL = URL(fileURLWithPath: pythonPath)
    process.arguments = [scriptPath]
    
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
                    // If the script fails, return the output as an error message
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
        
        // Set isRunning to false after the script finishes
        DispatchQueue.main.async {
            isRunning = false
        }
    }
}
