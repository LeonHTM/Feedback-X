import SwiftUI

struct SidebarView: View {
    @State private var selectedPage: String? // Tracks the selected page

    var body: some View {
        NavigationSplitView {
            // Sidebar
            List(selection: $selectedPage) {
                Section(header: Text("Feedback X").font(.system(size: 11)).foregroundColor(.gray)) {
                    NavigationLink(value: "RecentActivity") {
                        Label {
                            Text("Recent Activity")
                        } icon: {
                            Image(systemName: "clock")
                                .foregroundColor(.purple)
                        }
                    }
                    NavigationLink(value: "Accounts") {
                        Label {
                            Text("Accounts")
                        } icon: {
                            Image(systemName: "person")
                                .foregroundColor(.purple)
                        }
                    }
                }
                
                Section(header: Text("Settings & About").font(.system(size: 11)).foregroundColor(.gray)) {
                    NavigationLink(value: "Settings") {
                        Label {
                            Text("Settings")
                        } icon: {
                            Image(systemName: "gear")
                                .foregroundColor(.purple)
                        }
                    }
                    NavigationLink(value: "About") {
                        Label {
                            Text("About")
                        } icon: {
                            Image(systemName: "clock")
                                .foregroundColor(.purple)
                        }
                    }
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

