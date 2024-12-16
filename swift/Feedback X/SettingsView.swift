import SwiftUI

struct SettingsView: View {
    @State var SyncOpen: Bool = false
    
    var body: some View {
        TabView{
            Tab("Main",systemImage:"gear"){
                Form{
                    // Synchronisation Section
                    VStack(alignment: .leading) {
                        Text("Synchronisation")
                            .fontWeight(.bold)
                        Toggle(isOn: $SyncOpen) {
                            Text("Sync to Open Feedback Repository")
                        }
                        .padding(.vertical, 5)
                        .padding(.leading, 10)
                    }
                    .padding(.horizontal, 10) // Consistent padding for the entire section
                    
                    // Resets Section
                    VStack(alignment: .leading) {
                        Text("Resets")
                            .fontWeight(.bold)
                        
                        Button(action: {}) {
                            Text("Reset Warnings")
                        }
                        .padding(.vertical, 5)
                        .padding(.leading, 10)
                        
                        Text("This will show all Warnings again")
                        
                            .padding(.leading, 10)
                        
                        Button(action: {}) {
                            Text("Reset Accounts")
                        }
                        .padding(.vertical, 5)
                        .padding(.leading, 10)
                        Text("All Accounts will be reset, The App will have no Accounts saved")
                            .padding(.leading, 10)
                        
                        Button(action: {}) {
                            Text("Reset Feedbacks")
                        }
                        .padding(.vertical, 5)
                        .padding(.leading, 10)
                        Text("The App will forget all Feedbacks sent")
                            .padding(.leading, 10)
                    }
                    .padding(.horizontal, 10)
                }.padding(10)
            }
        }
    }
}

#Preview {
    SettingsView()
}

