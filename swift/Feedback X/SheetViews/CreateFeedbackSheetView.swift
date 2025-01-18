//
//  CreateFeedbackSheetView.swift
//  Feedback X
//
//  Created by Leon  on 19.12.2024.
//  Copyright © 2024 LeonHTM. All rights reserved.
//

import SwiftUI

struct CreateFeedbackSheetView: View {
    // MARK: - State Variables
    @State private var feedbackTitle: String = ""
    @State private var feedbackPath: String = ""
    @State private var feedbackDescription: String = ""
    @State private var areaSave: String = ""
    @State private var typeSave:String = ""
    @State private var topicSave: String = "iOS & iPadOS"
    @State private var showFileImporter = false
    @State private var selectedFiles: [String] = []
    @State private var showAlert: Bool = false
    @State private var errorMessage: String = ""
    @State private var isOnline: Bool = false
    @State private var onlineAlert: Bool = false

    @State private var submitSave: String = ""
    @State private var iterationSave: Double = 1
    @State private var sliderSave: Double = 2
    @State private var sliderSave2: Double = 1
    @State private var shouldRewrite: Bool = false
    @State private var headless: Bool = false

    @State private var accountURL = URL(fileURLWithPath: "/Users/leon/Desktop/Feedback-X/python/accounts/accounts.json")
    @State private var feedbackURL = URL(fileURLWithPath: "/Users/leon/Desktop/Feedback-X/python/current_fdb/content.txt")
    
    @State private var finalString: String = ""
    @State private var pythonOutPutString: String = ""
    @State private var buttonAllowed: Bool = true
    @State private var goneWrong: Bool = false
    @State private var shouldSync: Bool = false
    
    @State private var showCloseAlert: Bool = false
    @State public var showHelpSheet: Bool = false
    
    @Binding var showSheet: Bool
    @AppStorage("DeveloperSettings") var developerSettings: Bool = false
    @AppStorage("syncOpen") var syncOpen: Bool = false
    
    @EnvironmentObject var accountLoader: AccountLoader
    @EnvironmentObject var feedbackPython: FeedbackPython

    // MARK: - Computed Properties
    private var isSubmitEnabled: Bool {
        return !feedbackTitle.isEmpty && !feedbackDescription.isEmpty && !areaSave.isEmpty && !typeSave.isEmpty && !submitSave.isEmpty && !topicSave.isEmpty
    }

    // MARK: - Functions
    func feedbackRun() {
        feedbackPython.run(
            startValue: 1,
            iterationValue: Int(sliderSave),
            submitValue: submitSave,
            titleValue: feedbackTitle,
            pathValue: finalString,
            headlessValue: !headless,
            uploadValue: selectedFiles,
            topicValue: topicSave
        ) { success, output, error in
            if success {
                if let outputpy = feedbackPython.output {
                    if outputpy.range(of: "Failed") != nil {
                        goneWrong = true
                    } else {
                        buttonAllowed = true
                        showSheet = false
                    }
                } else {
                    goneWrong = true
                }
            }
        }
    }

    // MARK: - Body
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        // Feedback Topic Section
                        Text("Topic")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("What is your Feedback Topic?")

                        ZStack(alignment: .leading) {
                            if topicSave.isEmpty {
                                Text("Please select the topic").padding(.leading, 7)
                                    .foregroundStyle(.secondary)
                                    .opacity(0.5)
                            }
                            Picker("", selection: $topicSave) {
                                Text("iOS & iPadOS").tag("iOS & iPadOS")
                            }.labelsHidden()
                        }

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
                        ZStack(alignment: .leading) {
                            if areaSave.isEmpty {
                                Text("Please select the feedback area").padding(.leading, 7)
                                    .foregroundStyle(.secondary)
                                    .opacity(0.5)
                            }
                            Picker("", selection: $areaSave) {
                                ForEach(PublicSaves.feedbackAreasiOS, id: \.self) { type in
                                    Text(type)
                                }
                            }.labelsHidden()
                        }

                        // Feedback Type Section
                        Text("What type is the Feedback?")
                        ZStack(alignment: .leading) {
                            if typeSave.isEmpty {
                                Text("Please select the feedback type").padding(.leading, 7)
                                    .foregroundStyle(.secondary)
                                    .opacity(0.5)
                            }
                            Picker("", selection: $typeSave) {
                                Text("Incorrect/Unexpected Behavior").tag("1")
                                Text("Application Crash").tag("2")
                                Text("Suggestion").tag("3")
                                Text("Battery Life").tag("4")
                                Text("Suggestion").tag("5")
                            }.labelsHidden()
                        }

                        // Feedback Path Section
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
                            Button(action: { showFileImporter = true }) {
                                HStack {
                                    Text("Add Attachment")
                                        .foregroundColor(.accentColor)
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.accentColor)
                                }
                            }.buttonStyle(PlainButtonStyle())
                        }

                        // File Importer Logic
                        .fileImporter(
                            isPresented: $showFileImporter,
                            allowedContentTypes: [.data],
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

                        // Display Selected Files
                        if !selectedFiles.isEmpty {
                            VStack(alignment: .leading, spacing: 5) {
                                ForEach(selectedFiles, id: \.self) { file in
                                    HStack {
                                        Image(systemName: "document")
                                        Text(URL(fileURLWithPath: file).lastPathComponent)
                                            .foregroundColor(.gray)
                                        Spacer()
                                        Button(action: {
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
                            .padding(10)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                        } else {
                            HStack {
                                Image(systemName: "face.smiling")
                                Text("No Attachments chosen")
                                Spacer()
                            }
                            .padding(10)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                        }

                        // Automation Section
                        Text("Automation")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("How many times is the Feedback supposed to be sent?")

                        if iterationSave >= 2 {
                            Text("Feedback will be sent \(Int(sliderSave)) times").padding(.vertical, -10)
                            Slider(
                                value: $sliderSave,
                                in: 2...iterationSave,
                                step: 1.0
                            )
                            .onAppear {
                                accountLoader.loadAccounts(from: accountURL)
                                iterationSave = max(1, Double(accountLoader.accounts.count))
                                sliderSave = max(1, sliderSave)
                            }
                        } else {
                            Slider(value: $sliderSave2, in: 1...2, step: 1.0)
                                .disabled(true)
                            Text("This option is only available after having added at least two Apple Accounts (former Apple IDs) in Accounts")
                                .foregroundColor(.gray)
                                .font(.system(size: 12))
                                .padding(.top, -10)
                        }

                        Text("What action do you want to take with the feedback?")
                        ZStack(alignment: .leading) {
                            if submitSave.isEmpty {
                                Text("Please select the action you want to take with the feedback").padding(.leading, 7)
                                    .foregroundStyle(.secondary)
                                    .opacity(0.5)
                            }
                            Picker("", selection: $submitSave) {
                                Text("Submit Feedback").tag("submit")
                                Text("Save Feedback").tag("save")
                            }.labelsHidden()
                        }

                        Toggle(isOn: $shouldRewrite) {
                            Text("Rewrite Details with AI on every iteration")
                        }.disabled(true)

                        Text("This option is only available after having set up rewrite in Settings")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                            .padding(.top, -10)

                        if syncOpen {
                            Toggle(isOn: $shouldSync) {
                                Text("Sync Feedback to Open Feedback Repository")
                            }
                        } else {
                            Toggle(isOn: $shouldSync) {
                                Text("Sync Feedback to Open Feedback Repository")
                            }.disabled(true)
                            Text("This option is only available after having connected Open Feedback Repository in Settings")
                                .foregroundColor(.gray)
                                .font(.system(size: 12))
                                .padding(.top, -10)
                        }

                        Toggle(isOn: $headless) {
                            Text("Show Browser Window that automates Feedback")
                        }
                        Text("You will be able to interact with the Window therefore could potentially interfere with the automation")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                            .padding(.top, -10)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                }
                .disabled(!buttonAllowed)
                .onAppear {
                    accountLoader.loadAccounts(from: accountURL)
                    iterationSave = Double(accountLoader.accounts.count)
                }
                .alert("Error", isPresented: $showAlert) {
                    Button("OK", role: .cancel) {}
                } message: {
                    Text(errorMessage)
                }

                Divider()

                // Footer Buttons
                HStack {
                    Button(action: { showHelpSheet = true }) {
                        Image(systemName: "questionmark.circle.fill")
                            .font(.system(.title2))
                            .foregroundColor(.gray)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding()
                    .sheet(isPresented: $showHelpSheet) {
                        HelpMeView()
                            .frame(minWidth: 1100, minHeight: 750)
                    }

                    Spacer()

                    if developerSettings {
                        Text("Submit: \(submitSave), Title: \(feedbackTitle), Path: \(feedbackPath), Headless: \(headless), Selected Files: \(selectedFiles), areaSave: \(areaSave), Final: \(finalString); Iterations: \(sliderSave)").foregroundStyle(Color.secondary)
                    }

                    Spacer()

                    if !isSubmitEnabled {
                        Text("You haven't filled every field yet")
                        
                    }else if isSubmitEnabled && iterationSave < 2 {
                        if iterationSave == 0{
                            Text("You currently have \(Int(iterationSave)) Accounts. Please add at least 2 Accounts.")}else{
                                
                                Text("You currently have \(Int(iterationSave)) Account. Please add at least 2 Accounts.")
                            }
                    }

                    Button(action: {
                        showSheet = false
                        feedbackPython.stop()
                    }) {
                        Text("Close")
                            .padding(5)
                    }.disabled(!buttonAllowed)

                    Button(action: {
                        
                        do {
                            try StringToFile.writeToFile(input: feedbackDescription, filePath: feedbackURL)
                        } catch {
                            print("Failed to write file: \(error)")
                        }
                        finalString = feedbackPath.isEmpty ? "\(areaSave),\(typeSave)" : "\(areaSave),\(typeSave),\(feedbackPath)"
                        
                        OnlineCheck.checkGoogle{isOnline in
                            if isOnline == true{
                                feedbackRun()
                                buttonAllowed = false
                            }else{
                                
                                onlineAlert = true
                            }
                            
                        }
                        
                        
                        
                    }) {
                        Text("Submit")
                            .padding(5)
                    }
                    .disabled(!isSubmitEnabled || !buttonAllowed || iterationSave < 2)
                    .background(isSubmitEnabled && buttonAllowed ? Color.accentColor : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                    .padding(.trailing)
                    .alert("No Internet Connection", isPresented: $onlineAlert) {
                        Button("OK", role: .cancel) {}
                    } message: {
                        Text("Your Device is offline. Please check your internet connection and try again.")
                    }
                }
                .frame(width: 1000)
            }

            // Progress View for Feedback Submission
            if !buttonAllowed {
                VStack {
                    if !goneWrong {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                            .scaleEffect(1.0, anchor: .center)

                        Text(feedbackPython.output ?? "Started Duplication Cycle")
                            .onChange(of: feedbackPython.output) {
                                if let outputpy = feedbackPython.output, outputpy.range(of: "Failed") != nil {
                                    //print(feedbackPython.output)
                                    goneWrong = true
                                    feedbackPython.stop()
                                }
                            }
                    } else {
                        Text(feedbackPython.output ?? "")
                        Text("Do you want to try again?")
                        Button(action: {
                            goneWrong = false
                            feedbackRun()
                        }) {
                            Text("Try again")
                        }

                        if !headless && goneWrong {
                            Text("Tip: Show the Browser Window running the automation to identify issues")
                            Toggle(isOn: $headless) {
                                Text("Turn on Browser Window")
                            }
                        }

                        Button(action: { showSheet = false }) {
                            Text("Quit")
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.9))
                .cornerRadius(10)
            }
        }
    }
}


#Preview {
    @Previewable @StateObject var accountLoader = AccountLoader()
    @Previewable @StateObject var feedbackPython = FeedbackPython(scriptPath:"/Users/leon/Desktop/Feedback-X/python/code/main.py")
    CreateFeedbackSheetView(showSheet: .constant(true))
        .environmentObject(accountLoader)
}

