//
//  SettingsView.swift
//  MatchaFinder
//

import SwiftUI
import UserNotifications

struct SettingsView: View {
    @Environment(LocationManager.self) private var location

    @AppStorage("proximityNotificationsEnabled") private var proximityNotificationsEnabled = false
    @State private var notificationStatusText = "Not requested"

    var body: some View {
        NavigationStack {
            List {
                Section("MatchaFinder") {
                    LabeledContent("App") {
                        Text("MatchaFinder")
                    }
                }

                Section("Location") {
                    Text("Allow location while using the app to see distances and your position on the map.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    Button("Request location access") {
                        location.requestWhenInUse()
                    }
                    .tint(MatchaTheme.primary)
                    Button("Open Settings") {
                        if let url = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(url)
                        }
                    }
                    .tint(MatchaTheme.primary)
                }

                Section("Notifications") {
                    Toggle(
                        "Notify when near favorites",
                        isOn: $proximityNotificationsEnabled
                    )
                    .tint(MatchaTheme.primary)
                    Text("Iteration 1: preference only; geofences come later.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Button("Demo: request notification permission") {
                        requestNotificationDemo()
                    }
                    .tint(MatchaTheme.primary)
                    Text(notificationStatusText)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Settings")
            .scrollContentBackground(.hidden)
            .background(MatchaTheme.secondary)
        }
    }

    private func requestNotificationDemo() {
        // Optional iteration-1 demo only — no geofences or scheduled alerts yet.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, _ in
            DispatchQueue.main.async {
                notificationStatusText = granted ? "Authorized" : "Not authorized"
            }
        }
    }
}

#Preview {
    SettingsView()
        .environment(LocationManager())
}
