import SwiftUI
import Foundation


struct CreateFeedbackView: View {
    var body: some View {
        VStack {
            Text("Run Pyhon Script")
                .font(.system(size:32))
                .frame(width:200,height:200)
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
            Image(systemName:"exclamationmark.bubble")
                .imageScale(.large)
                
            
        }    }
}



#Preview {
    CreateFeedbackView()
}


