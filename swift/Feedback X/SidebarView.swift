import SwiftUI

struct SidebarView: View {
    @State private var selectedPage: String? // Tracks the selected page

    var body: some View {
        NavigationSplitView {
            // Sidebar
            List(selection: $selectedPage) {
                Section(header: Text("Feedback X").font(.system(size: 11)).foregroundColor(.gray)) {
                    NavigationLink(value: "RecentActivity") {
                        Label("Recent Activity",systemImage:"clock")
                    }
                    NavigationLink(value: "Accounts") {
                        Label("Accounts",systemImage:"person")
                    }
                }
                
                Section(header: Text("Settings & About").font(.system(size: 11)).foregroundColor(.gray)) {
                    NavigationLink(value: "Settings") {
                        Label("Settings",systemImage:"gear")
                    }
                    NavigationLink(value: "About") {
                        Label("About",systemImage:"person")}
                }
            }            .frame(minWidth: 200)
            .listStyle(SidebarListStyle())
            .navigationTitle("Sidebar")
            .tint(.purple)
        } detail: {
            // Detail view
            if let selectedPage = selectedPage {
                switch selectedPage {
                case "RecentActivity":
                    CreateFeedbackView()
                case "Accounts":
                    AccountsView()
                case "Settings":
                    SettingsView()
                case "About":
                    AboutView()
                default:
                    Text("Select a page") // Default fallback
                }
            } else {
                Text("Select a page") // Default message when no page is selected
            }
        }
    }
}



#Preview {
    SidebarView().tint(.purple)
}

