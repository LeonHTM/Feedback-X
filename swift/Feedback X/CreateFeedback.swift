import SwiftUI
import Foundation


struct CreateFeedback: View {
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
            .background(isRunning ? Color.gray : Color(red: 155/255,green: 51/255, blue: 162/255))
            .buttonStyle(PlainButtonStyle())
            .cornerRadius(10)
            .disabled(isRunning) // Disable the button when the script is running
            .padding()
            Spacer()
        }.padding(30)
    }
}



#Preview {
    CreateFeedback()
}


