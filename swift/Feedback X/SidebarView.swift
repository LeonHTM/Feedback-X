import SwiftUI

struct SidebarView: View {
    @State private var selectedPage: String? = "RecentActivity"
    var body: some View {
        NavigationSplitView {
            List(selection: $selectedPage) {
                Section(header: Text("Feedback X")
                    .font(.system(size: 11))
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                ) {
                    NavigationLink(value: "RecentActivity") {
                        Label("Recent Activity", systemImage: "clock")
                            .frame(maxWidth: .infinity, alignment: .leading) // Left-align label text
                    }
                    NavigationLink(value: "Accounts") {
                        Label("Accounts", systemImage: "person")
                            .frame(maxWidth: .infinity, alignment: .leading) // Left-align label text
                    }
                }

                Section(header: Text("About")
                    .font(.system(size: 11))
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading) // Ensure the header is left-aligned
                ) {
                    NavigationLink(value: "About") {
                        Label("About", systemImage: "questionmark.circle")
                            .frame(maxWidth: .infinity, alignment: .leading) // Left-align label text
                    }
                }
            }
            .listStyle(SidebarListStyle())
            
        } detail: {
            // Display the appropriate view based on the selected page
            if let selectedPage = selectedPage {
                switch selectedPage {
                case "RecentActivity":
                    CreateFeedbackView()
                case "Accounts":
                    AccountsView()
                case "About":
                    AboutView()
                default:
                    CreateFeedbackView() // Default fallback
                }
            } else {
                CreateFeedbackView() // Default view when no page is selected
            }
        }
        .frame(alignment: .leading)

    }
}

#Preview {
    SidebarView()
}

