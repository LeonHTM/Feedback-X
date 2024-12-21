//
//  CreateFeedbackSheetView.swift
//  Feedback X
//
//  Created by Leon  on 19.12.2024.
//  Copyright © 2024 LeonHTM. All rights reserved.
//

import SwiftUI
import UniformTypeIdentifiers

struct CreateFeedbackSheetView: View {
    @State private var feedbackTitle: String = ""
    @State private var feedbackPath: String = ""
    @State private var feedbackDescription: String = ""
    @State private var selectedOption = "Option 1"
    @State private var showFileImporter = false
    @State private var selectedFiles: [String] = []
    @State private var showAlert = false
    @State private var errorMessage: String = ""
    private var isSubmitEnabled: Bool {
            return !feedbackTitle.isEmpty && !feedbackDescription.isEmpty && !selectedOption.isEmpty
        }
    @State private var showCloseAlert = false
    @State public var showHelpSheet = false
    @Binding var showSheet: Bool
   
    
    

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                // Basic Information Section
                Text("Basic Information")
                    .font(.title)
                    .fontWeight(.bold)

                Text("Please provide a descriptive title for your feedback")
                TextField("", text: $feedbackTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text("Example: Unable to make phone calls from lock screen in iOS 18.2 (22C152)")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 12))
                Text("Which area are you seeing an Issue with?")
                Picker("", selection: $selectedOption) {
                    Text("Chocolate").tag("Chocolate1")
                    Text("Vanila").tag("Vanila1")
                    Text("Strawberry").tag("Strawberry1")
                }.labelsHidden()
                Text("What type of feedback are you reporting?")
                Picker("", selection: $selectedOption) {
                    Text("Chocolate").tag("Chocolate")
                    Text("Vanila").tag("Vanila")
                    Text("Strawberry").tag("Strawberry")
                }.labelsHidden()
                Text("What is your feedback path?")
                TextField("", text: $feedbackPath)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Text("Example: 5,3,4,5 (Options you chose after area and type)")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 12))
                

                // Description Section
                Text("Description")
                    .font(.title)
                    .fontWeight(.bold)

                TextEditor(text: $feedbackDescription)
                    .frame(height: 100)
                    .border(Color.gray, width: 1)

                // Attachments Section
                HStack {
                    Text("Attachments")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: {
                        showFileImporter = true
                    }) {
                        HStack {
                            Text("Add Attachment")
                                .foregroundColor(.accentColor)
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.accentColor)
                        }
                    }.buttonStyle(PlainButtonStyle())
                }
                .fileImporter(
                    isPresented: $showFileImporter,
                    allowedContentTypes: [.data], // Customize file types as needed
                    allowsMultipleSelection: false
                ) { result in
                    switch result {
                    case .success(let urls):
                        for url in urls {
                            selectedFiles.append(url.path)
                        }
                    case .failure(let error):
                        errorMessage = "Failed to import file: \(error.localizedDescription)"
                        showAlert = true
                    }
                }

                // Display selected files
                if !selectedFiles.isEmpty {
                    HStack{
                        VStack(alignment: .leading, spacing: 5) {
                            ForEach(selectedFiles, id: \.self) { file in


                                HStack{
                                    Image(systemName: "document")
                                    Text("\(URL(fileURLWithPath: file).lastPathComponent)")
                                        .foregroundColor(.gray)
                                    Spacer()

                                    Button(action: {
                                        // Logic to show the file in the file browser
                                        let fileURL = URL(fileURLWithPath: file)
                                        if FileManager.default.fileExists(atPath: file) {
                                            NSWorkspace.shared.activateFileViewerSelecting([fileURL])
                                        } else {
                                            errorMessage = "File not found: \(file)"
                                            showAlert = true
                                        }
                                    }) {
                                        Image(systemName: "magnifyingglass")
                                    }.buttonStyle(PlainButtonStyle())

                                    Button(action: {
                                        // Logic to remove the file from the list
                                        selectedFiles.removeAll { $0 == file }
                                    }) {
                                        Image(systemName: "trash")
                                    }.buttonStyle(PlainButtonStyle())
                                }
                                if file != selectedFiles.last {
                                    Divider()
                                }
                            }
                        }
                        Spacer()
                    }
                    .padding(10)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                }
                
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
        }
        .alert("Error", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(errorMessage)
        }
        Divider()
        HStack{
            Button(action: {
                showHelpSheet = true
                
            }) {
                Image(systemName: "questionmark.circle.fill")
                    .font(.system(.title2))
                    .foregroundColor(.gray)
                    
                    
            }
            .buttonStyle(PlainButtonStyle())
            .padding()
            .sheet(isPresented: $showHelpSheet) {
                HelpMeView()
                    .frame(minWidth: 1100, minHeight: 750) // Add minimum width and height here
            }

    
            Spacer()
            if isSubmitEnabled == false{
                Text("You Haven't filled every Field yet")}
            Button(action: {
                showSheet = false
            }) {
                Text("Close")
                    .padding(5) // Add padding around the text
            }
            
            
            
            
            
            Button(action: {
                showSheet = false
            }) {
                Text("Submit")
                    .padding(5) // Add padding around the text
            }
            .disabled(!isSubmitEnabled)
          
            .background(isSubmitEnabled ? Color.accentColor: Color.gray)
            .foregroundColor(.white)
            .cornerRadius(5)
            
            .padding([.trailing,])
        }
        
        
        
    }
       
}

#Preview {
    CreateFeedbackSheetView(showSheet: .constant(true))
}

