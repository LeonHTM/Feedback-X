//
//  TestRewriteView.swift
//  Feedback X
//
//  Created by Leon  on 18.12.2024.
//  Copyright © 2024 LeonHTM. All rights reserved.
//

import SwiftUI

struct TestRewriteView: View {
    
    @State private var isLoading: Bool = false
    @State private var errorMessage: String? = nil
    @State private var showAlert: Bool = false
    @State private var selectedFilePath: String? = "/Users/leon/Desktop/Feedback-x/python/code/rewrite.py"

    var body: some View {
        VStack {
            
        
            Text("Test Rewriting here").padding(40)
            
            if let selectedFilePath = selectedFilePath {
                Text("Selected file: \(selectedFilePath)")
                    .foregroundColor(.gray)
                    .padding(.bottom, 10)
            }
            Button("Run Selected Script") {
                guard let scriptPath = selectedFilePath else {
                    errorMessage = "No script selected!"
                    showAlert = true
                    return
                }

                isLoading = true
                errorMessage = nil

                runPythonScript(scriptPath: scriptPath) { success, output, error in
                    DispatchQueue.main.async {
                        isLoading = false
                        
                        if let error = error {
                            errorMessage = error.localizedDescription
                        } else if let output = output {
                            errorMessage = output
                        }
                        
                        showAlert = true
                    }
                }
            }
            .padding()
            .disabled(isLoading || selectedFilePath == nil)
            
            if isLoading {
                ProgressView("Running script...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .padding()
            }
        
        }
        .padding(30)
        .sheet(isPresented: $showAlert) {
            VStack {
                Text("An Error Occurred")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()

                ScrollView {
                    Text(errorMessage ?? "Unknown Error")
                        .font(.body)
                        .padding()
                }

                Button("OK") {
                    showAlert = false
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }

    }
}

#Preview {
    TestRewriteView()
}
