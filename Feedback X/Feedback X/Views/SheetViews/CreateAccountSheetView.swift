import SwiftUI

struct CreateAccountSheetView: View {
    
    // URL to store account information
    @AppStorage("accountsPath") var accountsPath: String = "/Users/leon/Desktop/Feedback-X/python/accounts/accounts.json"
    var accountURL: URL {
        URL(fileURLWithPath: accountsPath)
    }
    
    @EnvironmentObject var accountLoader: AccountLoader
    @AppStorage("helpSelectedPage") var helpSelectedPage: String = "Create Accounts"
    
    // Form fields
    @State private var icloudmailSave: String = ""
    @State private var passwordSave: String = ""
    @State private var noteSave: String = "Notes"
    @State private var cookiesSave = "n"
    @State private var appledevSave = ""
    @State private var countrySave: String = ""
    
    // State management variables
    @State private var isEmailInvalid = false
    @State private var debounceWorkItem: DispatchWorkItem?
    @State private var alreadyClicked: Bool = false
    @State private var isSubmitEnabled: Bool = false
    
    // Default expiration date (30 days from now)
    @State var dateSave = Calendar.current.date(byAdding: .day, value: 30, to: Date())?
        .formatted(Date.FormatStyle()
            .day(.defaultDigits)
            .month(.defaultDigits)
            .year())
    
    // UI control states
    @State private var showAlert = false
    @State private var errorMessage: String = ""
    @State private var showDuplicateAlert = false
    @Binding var showSheet: Bool
    @Environment(\.colorScheme) var colorScheme
    
    // Checks if all required fields are filled before allowing submission
    func submitTest() {
        if !icloudmailSave.isEmpty && !passwordSave.isEmpty && !appledevSave.isEmpty && !countrySave.isEmpty {
            isSubmitEnabled = true && !isEmailInvalid
        }
    }
    
    // Saves the account information if valid
    func save() {
        alreadyClicked = true
        submitTest()
        
        if isSubmitEnabled {
            dateSave = nil // Reset the date
            
            let newAccount = Account(
                account: icloudmailSave,
                icloudmail: icloudmailSave,
                password: passwordSave,
                relay: icloudmailSave,
                country: countrySave,
                appledev: appledevSave,
                cookies: "n",
                note: noteSave,
                date: dateSave ?? "No cookies added yet"
            )
            
            // Check for duplicates before adding
            if accountLoader.addAccount(newAccount, to: accountURL) == false {
                showDuplicateAlert = true
            } else {
                showSheet = false
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text("Basic Information").font(.title).fontWeight(.bold)
                
                Text("Please provide the iCloud login credentials").padding(.bottom, -10).offset(x: 3)
                
                // Email input field with validation
                HStack(spacing: 0) {
                    if alreadyClicked && icloudmailSave.isEmpty {
                        Image(systemName: "arrow.right.circle.fill").foregroundStyle(Color.red).padding(.horizontal, -17)
                    }
                    TextField("Mail", text: $icloudmailSave)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: icloudmailSave) {
                            debounceWorkItem?.cancel()
                            debounceWorkItem = DispatchWorkItem {
                                let emailRegex = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$"
                                let isValid = icloudmailSave.range(of: emailRegex, options: [.regularExpression, .caseInsensitive]) != nil
                                isEmailInvalid = !isValid && !icloudmailSave.isEmpty
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: debounceWorkItem!)
                        }
                }
                
                if isEmailInvalid {
                    HStack {
                        Image(systemName: "exclamationmark.circle")
                        Text("Enter a valid email address")
                    }
                    .foregroundStyle(Color.red)
                    .padding(.vertical, -15)
                    .offset(x: 3, y: 3)
                }
                
                // Password input field
                HStack(spacing: 0) {
                    if alreadyClicked && passwordSave.isEmpty {
                        Image(systemName: "arrow.right.circle.fill").foregroundStyle(Color.red).padding(.horizontal, -17)
                    }
                    SecureInputView("Password", text: $passwordSave)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                // Warning message about password security
                HStack(alignment: .top, spacing: 5) {
                    Image(systemName: "exclamationmark.circle.fill").foregroundStyle(.yellow).offset(y: 1)
                    Text("Passwords are stored in plain text. Avoid using passwords that you use elsewhere.")
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.leading)
                }
                
                Text("Details").font(.title).fontWeight(.bold)
                
                // Apple Developer selection
                HStack(spacing:0){
                                    if alreadyClicked == true && appledevSave.isEmpty{
                                        Image(systemName:"arrow.right.circle.fill")
                                            .foregroundStyle(Color.red)
                                            .padding(.horizontal,-17)
                                            .offset(y:5)
                                    }
                                    
                                    Text("Does the Account have Apple Developer?")
                                        .padding(.bottom,-10)
                                        .offset(x:3)
                                        
                                }
                ZStack(alignment:.leading){
                                  
                                  Picker("", selection: $appledevSave) {
                                      Text("Set up").tag("y")
                                      Text("Not set up").tag("n")
                                  }.labelsHidden()
                                  if appledevSave == ""{
                                      Text("Apple Developer").padding(.leading, 7)
                                          .foregroundStyle(.primary.opacity(0.7))
                                          .opacity(0.5)
                                  }
                              }
                
                // Country selection
                HStack(spacing:0){
                    if alreadyClicked == true && countrySave.isEmpty{
                        Image(systemName:"arrow.right.circle.fill")
                            .foregroundStyle(Color.red)
                            .padding(.horizontal,-17)
                            .offset(y:5)
                    }
                    
                    Text("Please select the country of origin")
                        .padding(.bottom,-10)
                        .offset(x:3)
                }
                ZStack(alignment:.leading){
                                    
                                    Picker("", selection: $countrySave) {
                                        ForEach(PublicSaves.countriesAndTerritories, id: \.self) { country in
                                            Text(country)
                                        }
                                    }.labelsHidden()
                                    if countrySave == ""{
                                        Text("Country").padding(.leading, 7)
                                            .foregroundStyle(.primary.opacity(0.5))
                                            .opacity(0.5)
                                    }
                                }
                
                // Notes input
                Text("Add note").padding(.bottom, -10)
                TextEditor(text: $noteSave).frame(height: 100).border(Color.gray, width: 1)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
        }
        .onAppear { accountLoader.loadAccounts(from: accountURL) }
        .alert("Error", isPresented: $showAlert) { Button("OK", role: .cancel) {} } message: { Text(errorMessage) }
        
        // Action buttons
        Divider()
        HStack{
            Button(action: {
                helpSelectedPage = "Add Accounts"
                OpenHelpWindow.open()
                
                
            }) {
                ZStack{
                    Image(systemName: "circle.fill")
                        .font(.system(size:20))
                        .foregroundStyle(colorScheme == .dark ? Color.gray.opacity(0.5) : Color.white)
                        .shadow(radius: 1)
                    Text("?")
                        .foregroundStyle(colorScheme == .dark ? Color.white : Color.black)
                        .font(.system(size:17))
                    
                }
            }
            .buttonStyle(PlainButtonStyle())
            .padding()
            Spacer()
            Button(action: {
                showSheet = false
            }) {
                Text("Close")
                    .padding(5) // Add padding around the text
            }
            
            
            
            
            
            Button(action: {
                save()
            }) {
                Text("Save")
                    .padding(.vertical,6.3)
                    .padding(.horizontal,10) // Add padding around the text
            }
            //.disabled(!isSubmitEnabled)
            .alert("Account already exists", isPresented: $showDuplicateAlert) {
                
                Button("Quit Add Account", role: .cancel) {
                    showSheet = false
                }
                Button("OK", role: .cancel) {
                    // This is where we handle the alert dismissing logic
                    showDuplicateAlert = false
                }
            } message: {
                Text("The account you tried to add already exists.")
            }
            .buttonStyle(PlainButtonStyle())
            .background(Color.accentColor)
            .foregroundColor(.white)
            .cornerRadius(5)
            .padding([.trailing,])
        }
        .padding(.top,-9.5)
        .frame(width:1000)
    }
}

#Preview {
    @Previewable @StateObject var accountLoader = AccountLoader()
    CreateAccountSheetView(showSheet: .constant(true)).environmentObject(accountLoader)
}

