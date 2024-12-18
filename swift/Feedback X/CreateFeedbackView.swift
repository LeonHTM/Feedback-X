import SwiftUI

struct CreateFeedbackView: View {
    @State private var isRunning = false
    @State private var showAlert = false
    @State private var showSheet = false
    @State private var feedbackTitle: String = ""
    @State private var selectedOption = "Option 1"
    @AppStorage("HasShownAlert") var hasShownAlert: Bool = false
    @AppStorage("AppLaunchCounter") var appLaunchCounter: Int = 1
    

    var body: some View {
        VStack {
            Text("Run Python Script")
                .font(.system(size: 32))
                .frame(width: 200, height: 200)
                .onAppear {
                    // Trigger alert only if appLaunchCounter is 1 and it hasn't been shown yet
                    if appLaunchCounter == 1 && !hasShownAlert {
                        showAlert = true
                        hasShownAlert = true // Ensure the alert is only shown once
                    }
                }

            Button(action: {
                ///runPythonScript(scriptPath: "/Users/leon/Desktop/Feedback-X/python/main.py",completion:True)
                showSheet = true
                
            }) {
                Text(isRunning ? "Running..." : "Run Python Script")
                    .padding(1)

            }
            
            //.background(isRunning ? Color.gray : Color.accentColor)
            //.buttonStyle(PlainButtonStyle())
            //.cornerRadius(10)
            .disabled(isRunning)
            .padding()
            .sheet(isPresented: $showSheet) {
                ScrollView{
                    VStack (alignment: .leading,spacing:10){
                        Text("Basic Information")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("Please provide a descriptive title for your feedback")
                        TextField("", text: $feedbackTitle)
                        Text("Example: Unable to make phone calls from lock screen in iOS 18.2 (22C152)")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                        Text("Which Area are you seings an Issue with?")
                        List {
                            Picker(selection: $selectedOption) {
                                Text("Chocolate")
                                Text("Vanilla")
                                Text("Strawberry")
                            } label: {
                                Text("Flavor")
                                Text("Choose your favorite flavor")
                            }
                        }
                        
                        
                        
                        Button("OK") {
                            showSheet = false
                        }
                        .padding()
                    }
                    .padding(.horizontal,60)
                    .padding(.vertical,20)
                }
            }

            
            

        }
        .alert("Legal Notice", isPresented: $showAlert) {
            Button("Quit Feedback X", role: .cancel) {
                showAlert = false
                appLaunchCounter = 0 // Reset counter or handle quitting
                exit(0)
            }
            Button("Accept") {}
        } message: {
            Text("By clicking 'Accept', you acknowledge and agree that you are solely responsible for any actions taken using this program. The developer and any associated parties are not liable for any consequences arising from the use of this program. Your use of the program indicates your acceptance of these terms.")
        }
    }
}

#Preview {
    CreateFeedbackView()
}

