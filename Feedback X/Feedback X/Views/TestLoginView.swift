//
//  TestLoginView.swift
//  Feedback X
//
//  Created by LeonHTM on 18.12.2024.
//  Copyright © 2024 LeonHTM. All rights reserved.
//

import SwiftUI
import UniformTypeIdentifiers

struct TestLoginView: View {
    @State private var isLoading: Bool = false
    @State private var errorMessage: String? = nil
    @State private var showAlert: Bool = false
    @State private var selectedFilePath: String? = nil
    @State private var showFileImporter: Bool = false

    var body: some View {
        VStack {
            Text("Test Login Cycle here")
                .padding(40)

            // Show the selected file path if any
            if let selectedFilePath = selectedFilePath {
                Text("Selected file: \(selectedFilePath)")
                    .foregroundColor(.gray)
                    .padding(.bottom, 10)
            }

            Button("Select a Python Script") {
                showFileImporter = true // Trigger file importer
            }
            .padding()
            .fileImporter(
                isPresented: $showFileImporter,
                allowedContentTypes: [.pythonScript, .plainText], // Allow Python scripts or text files
                allowsMultipleSelection: false
            ) { result in
                switch result {
                case .success(let urls):
                    if let firstURL = urls.first {
                        selectedFilePath = firstURL.path
                    }
                case .failure(let error):
                    errorMessage = "Failed to import file: \(error.localizedDescription)"
                    showAlert = true
                }
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
        .padding()
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
    TestLoginView()
}
