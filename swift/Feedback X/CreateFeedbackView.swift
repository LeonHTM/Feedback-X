import SwiftUI

struct CreateFeedbackView: View {
    @State private var isRunning = false
    @State private var showAlert = false
    @AppStorage("AppLaunchCounter") var appLaunchCounter: Int = 0
    
    var body: some View {
        VStack {
            Text("Run Python Script")
                .font(.system(size: 32))
                .frame(width: 200, height: 200)
                .onAppear {
                    if appLaunchCounter == 0 {
                        showAlert = true
                    }
                }
            
            Button(action: {
                runPythonScript()
            }) {
                Text(isRunning ? "Running..." : "Run Python Script")
                    .padding()
            }
            .background(isRunning ? Color.gray : Color.purple)
            .buttonStyle(PlainButtonStyle())
            .cornerRadius(10)
            .disabled(isRunning) // Disable the button when the script is running
            .padding()
            
            Image(systemName: "exclamationmark.bubble")
                .imageScale(.large)
        }
        .alert("Legal Notice", isPresented: $showAlert) {
            Button("Quit Feedback X", role: .cancel) {
                // Proper exit handling can be designed instead of `exit(0)`
                showAlert = false
            }
            Button("Accept") {
                appLaunchCounter += 1
            }
        } message: {
            Text("By clicking 'Accept', you acknowledge and agree that you are solely responsible for any actions taken using this program. The developer and any associated parties are not liable for any consequences arising from the use of this program. Your use of the program indicates your acceptance of these terms.")
        }
    }
}


#Preview {
    CreateFeedbackView()
}

