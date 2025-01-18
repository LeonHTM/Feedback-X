//
//  CreateFeedbackSheetView.swift
//  Feedback X
//
//  Created by Leon  on 19.12.2024.
//  Copyright © 2024 LeonHTM. All rights reserved.
//

import SwiftUI


struct CreateFeedbackSheetView: View {
    @State private var feedbackTitle: String = ""
    @State private var feedbackPath: String = ""
    @State private var feedbackDescription: String = ""
    @State private var areaSave = ""
    @State private var typeSave = ""
    @State private var topicSave: String = ""
    @State private var showFileImporter = false
    @State private var selectedFiles: [String] = []
    @State private var showAlert = false
    @State private var errorMessage: String = ""
    
    @State private var submitSave: String = ""
    
    @State private var iterationSave: Double = 1
    @State private var sliderSave: Double = 2
    @State private var sliderSave2: Double = 1
    
    @State private var shouldRewrite: Bool = false
    @State private var headless: Bool = false

    @State private var accountURL = URL(fileURLWithPath: "/Users/leon/Desktop/Feedback-X/python/accounts/accounts.json")
    
    @State private var feedbackURL = URL(fileURLWithPath: "/Users/leon/Desktop/Feedback-X/python/current_fdb/content.txt")
    
    @EnvironmentObject var accountLoader: AccountLoader
    @EnvironmentObject var feedbackPython: FeedbackPython
    
    
    private var isSubmitEnabled: Bool {
        return !feedbackTitle.isEmpty && !feedbackDescription.isEmpty && !areaSave.isEmpty && !typeSave.isEmpty && !submitSave.isEmpty && !topicSave.isEmpty 
        }
    @State private var showCloseAlert = false
    @State public var showHelpSheet = false
    @Binding var showSheet: Bool
    
    @AppStorage("DeveloperSettings") var developerSettings: Bool = false
    @AppStorage("syncOpen") var syncOpen: Bool = false
    @State private var shouldSync: Bool = false
    
    @State private var finalString: String = ""
    
   
    @State private var pythonOutPutString: String = ""
   
    @State private var buttonAllowed: Bool = true
    @State private var goneWrong: Bool = false
    
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
                                    //print(outputpy)
                                    if outputpy.range(of: "Failed") != nil {
                                        print("goneWrong")
                                        goneWrong = true
                                    } else {
                                        print("goneWell")
                                        buttonAllowed = true
                                        showSheet = false
                                    }
                                } else {
                                    print("No output from feedbackPython.")
                                    goneWrong = true
                                }
                
            } else if let error = error {
                //print("Error: \(error.localizedDescription)")
                //buttonAllowed = true // Enable the button to let the user retry
            } else {
                print("Unknown error occurred while running the script.")
                //buttonAllowed = true // Enable the button to let the user retry
            }
        }
    }
 


    var body: some View {
        
        ZStack{
            VStack{
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        // Basic Information Section
                        
                        
                        Text("Topic")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("What is your Feedback Topic?")
                        ZStack(alignment:.leading){
                            if topicSave == ""{
                                Text("Please select the topic").padding(.leading, 7)
                                    .foregroundStyle(.secondary)
                                    .opacity(0.5)
                            }
                            Picker("", selection: $topicSave) {
                                Text("iOS & iPadOS").tag("iOS & iPadOS")
                            }.labelsHidden()
                        }
                        
                        
                        
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
                            if areaSave == ""{
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
                        
                        Text("What type is the Feedback?")
                        ZStack(alignment:.leading){
                            if typeSave == ""{
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
                        
                        
                        if iterationSave >= 2 {
                            Text("Feedback will be sent \(Int(sliderSave)) times" ).padding(.vertical,-10)
                            Slider(
                                value: $sliderSave,
                                in: 2...iterationSave,
                                step: 1.0
                            )
                            .onAppear {
                                accountLoader.loadAccounts(from: accountURL)
                                iterationSave = max(1, Double(accountLoader.accounts.count)) // Ensure iterationSave is at least 2
                                sliderSave = max(1, sliderSave) // Adjust sliderSave to be within range
                            }
                        }else{
                            
                            Slider(
                                value: $sliderSave2,
                                in: 1...2,
                                step: 1.0
                            )
                            .disabled(true)
                            Text("This option is only available after having added at least two Apple Accounts (former Apple IDs) in Accounts")
                                .foregroundColor(.gray)
                                .font(.system(size: 12))
                                .padding(.top,-10)
                        }
                        
                        Text("What action do you wanna take with the feedback?")
                        ZStack(alignment:.leading){
                            if submitSave == ""{
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
                            .padding(.top,-10)
                        
                        if syncOpen == true{
                            Toggle(isOn: $shouldSync){
                                Text("Sync Feedback to Open Feedback Repository")
                            }
                            
                            
                        }else{
                            
                            Toggle(isOn: $shouldSync){
                                Text("Sync Feedback to Open Feedback Repository")
                            }.disabled(true)
                            Text("This option is only available after having connected Open Feedback Repository in Settings")
                                .foregroundColor(.gray)
                                .font(.system(size: 12))
                                .padding(.top,-10)
                            
                            
                        }
                        
                        
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
                .disabled(buttonAllowed == false)
                .onAppear{
                    accountLoader.loadAccounts(from:accountURL)
                    iterationSave  = Double(accountLoader.accounts.count)
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
                    if developerSettings == true{
                        Text("Submit: \(submitSave), Title: \(feedbackTitle),Path: \(feedbackPath), Headless: \(headless), Selected Files: \(selectedFiles), areaSave: \(areaSave), Final: \(finalString); Iterations: \(sliderSave)").foregroundStyle(Color.secondary)
                    }
                    Spacer()
                    if isSubmitEnabled == false{
                        Text("You haven't filled every field yet")}
                    Button(action: {
                        showSheet = false
                        feedbackPython.stop()
                    }) {
                        Text("Close")
                            .padding(5) // Add padding around the text
                    } .disabled(buttonAllowed == false)
                    
                    
                    
                    
                    
                    Button(action: {
                        buttonAllowed = false
                        do {
                            try StringToFile.writeToFile(input: feedbackDescription, filePath: feedbackURL)
                        }catch{
                            
                            print("Failed to write file: \(error)")
                        }
                        if feedbackPath != ""{
                            finalString = "\(areaSave),\(typeSave),\(feedbackPath)"
                        }else{
                            finalString = "\(areaSave),\(typeSave)"
                        }
                        
                        feedbackRun()
                        
                        
                        
                    }) {
                        Text("Submit")
                            .padding(5) // Add padding around the text
                    }
                    .disabled(!isSubmitEnabled || buttonAllowed == false)
                    
                    .background(isSubmitEnabled || buttonAllowed == true ? Color.accentColor: Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                    
                    .padding([.trailing,])
                }.frame(width:1000)
                
                
                
            }
            if buttonAllowed == false{
                VStack{
                    
                    if goneWrong != true{
                       
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                            .scaleEffect(1.0, anchor: .center)
                        Text(feedbackPython.output ?? "Started Duplication Cycle")
                            .onChange(of:feedbackPython.output){
                                
                                if let outputpy = feedbackPython.output {
                                    //print(outputpy)
                                    if outputpy.range(of: "Failed") != nil {
                                        print("goneWrong")
                                        goneWrong = true
                                        feedbackPython.stop()
                                    }
                                    
                                }
                                                

                                
                            }
                       
                           
                     
                    
                            
                        
                        
                        
                        
                    }else{
                        
                        Text("Something seems to have gone wrong. Do you wann try again?")
                        Button(action:{
                            goneWrong = false
                            feedbackRun()
                            
                        }){
                            
                            Text("Try again")
                            
                        }
                        if headless == false && goneWrong == true {
                            Text("Tip: show the Browser Window running the automation to show whats going wrong")
                            Toggle(isOn: $headless){
                                Text("Turn on Browser Window")
                            }
                        }
                        Button(action:{
                            
                            showSheet = false
                        }){
                            
                            Text("Quit")
                        }
                        
                        
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.5))
                .clipShape(
                    .rect(
                        topLeadingRadius: 10,
                        bottomLeadingRadius: 10,
                        bottomTrailingRadius: 10,
                        topTrailingRadius: 10
                    )
                )
                
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

