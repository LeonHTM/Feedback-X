import SwiftUI

struct SidebarView: View {
    @State private var selectedPage: String? = "RecentActivity" // Set the initial value to "RecentActivity"

    var body: some View {
        NavigationSplitView {
            // Sidebar
            List(selection: $selectedPage) {
                Section(header: Text("Feedback X").font(.system(size: 11)).foregroundColor(.gray)) {
                    NavigationLink(value: "RecentActivity") {
                        Label("Recent Activity", systemImage: "clock")
                    }
                    NavigationLink(value: "Accounts") {
                        Label("Accounts", systemImage: "person")
                    }
                }

                Section(header: Text("Settings & About").font(.system(size: 11)).foregroundColor(.gray)) {
                    NavigationLink(value: "Settings") {
                        Label("Settings", systemImage: "gear")
                    }
                    NavigationLink(value: "About") {
                        Label("About", systemImage: "person")
                    }
                }
            }
            .frame(minWidth: 200)
            .listStyle(SidebarListStyle())
            .navigationTitle("Sidebar")
            .tint(.purple)
        } detail: {
            // Display the appropriate view based on the selected page
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
                    CreateFeedbackView() // Default fallback
                }
            } else {
                CreateFeedbackView() // Default view when no page is selected
            }
        }
    }
}

#Preview {
    SidebarView()
}
