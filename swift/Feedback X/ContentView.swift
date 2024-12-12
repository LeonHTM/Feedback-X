//
//  ContentView.swift
//  Feedback X
//
//  Created by Leon  on 10.12.2024.
//

import SwiftUI
import Foundation

struct ContentView: View {
    // Action to run the Python script
    func runPythonScript() {
        let pythonPath = "/Users/leon/Desktop/Feedback-X/myenv/bin/python3"
        let scriptPath = "/Users/leon/Desktop/Feedback-X/python/code/main.py"
        
        // Create the Process instance to run the Python script
        let process = Process()
        process.executableURL = URL(fileURLWithPath: pythonPath)
        process.arguments = [scriptPath]
        
        // Set up a pipe to capture the output
        let pipe = Pipe()
        process.standardOutput = pipe
        process.standardError = pipe
        
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
    }

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            // Button to run the Python script
            Button(action: {
                runPythonScript()
            }) {
                Text("Run Python Script")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
