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
    @State private var selectedOption1 = ""
    @State private var selectedOption2 = ""
    @State private var showFileImporter = false
    @State private var selectedFiles: [String] = []
    @State private var showAlert = false
    @State private var errorMessage: String = ""
    
    @State private var shouldRewrite: Bool = false
    @State private var headless: Bool = false
    @State private var iterationValue: Int = 2
    
    
    private var isSubmitEnabled: Bool {
            return !feedbackTitle.isEmpty && !feedbackDescription.isEmpty && !selectedOption1.isEmpty && !selectedOption2.isEmpty
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
                
                ZStack(alignment:.leading){
                    if selectedOption1 == ""{
                        Text("Please select the problem area").padding(.leading, 7)
                            .foregroundStyle(.secondary)
                            .opacity(0.5)
                    }
                    Picker("", selection: $selectedOption1) {
                        Text("Chocolate").tag("Chocolate1")
                        Text("Vanila").tag("Vanila1")
                        Text("Strawberry").tag("Strawberry1")
                    }.labelsHidden()
                }
                
                Text("What type of feedback are you reporting?")
                ZStack(alignment:.leading){
                    if selectedOption2 == ""{
                        Text("Please select the type of feedback").padding(.leading, 7)
                            .foregroundStyle(.secondary)
                            .opacity(0.5)
                    }
                    Picker("", selection: $selectedOption2) {
                        Text("Chocolate").tag("Chocolate")
                        Text("Vanila").tag("Vanila")
                        Text("Strawberry").tag("Strawberry")
                    }.labelsHidden()
                }
            
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
                Text("Please describe the issue and what steps one can take to reproduce it:")

                TextEditor(text: $feedbackDescription)
                    .frame(height: 100)
                    .border(Color.gray, width: 1)
                Text("You should include:\n - A clear description of the Problem \n - Steps to reproduce \n - What Results you expect \n - What results you actually saw")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 12))

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
                }else{
                    HStack{
                        Image(systemName: "face.smiling")
                        Text("No Attachments chosen")
                        Spacer()
                    }
                        .padding(10)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
                Text("Automation")
                    .font(.title)
                    .fontWeight(.bold)
                Text("How many times is the Feedback supposed be sent?")
                Text("Feedback will be sent \(iterationValue) times" ).padding(.vertical,-10)
                Slider(
                                value: Binding(
                                    get: { Double(iterationValue) },
                                    set: { iterationValue = Int($0) }
                                ),
                                in: 2...10, // Range of the slider
                                step: 1 // Step size
                            )
                
                            
                Text("This option is only available after having added at least two Apple Accounts (former Apple IDs) in Accounts")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 12))
                                            .padding(.top,-10)
                Toggle(isOn: $shouldRewrite) {
                    Text("Rewrite Details with AI on every iteration")
                    
                }
                Text("This option is only available after having set up rewrite in Settings")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 12))
                                            .padding(.top,-10)
                Toggle(isOn: $headless) {
                    Text("Show Browser Window that automates Feedback")
                    
                }
                Text("You will be able to interact with the Window therefore could potentially interfere with the automation")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 12))
                                            .padding(.top,-10)
                
                
                
                
                
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
        }.frame(width:1000)
        
        
        
    }
       
}

#Preview {
    CreateFeedbackSheetView(showSheet: .constant(true))
}

