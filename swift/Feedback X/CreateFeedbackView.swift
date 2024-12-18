import SwiftUI

struct CreateFeedbackView: View {
    @State private var isRunning = false
    @State private var showAlert = false
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
                runPythonScript()
            }) {
                Text(isRunning ? "Running..." : "Run Python Script")
                    .padding()
            }
            .background(isRunning ? Color.gray : Color.purple)
            .buttonStyle(PlainButtonStyle())
            .cornerRadius(10)
            .disabled(isRunning)
            .padding()

            Image(systemName: "exclamationmark.bubble")
                .imageScale(.large)
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

