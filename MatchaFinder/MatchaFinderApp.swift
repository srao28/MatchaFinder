//
//  MatchaFinderApp.swift
//  MatchaFinder
//

import SwiftData
import SwiftUI

@main
struct MatchaFinderApp: App {
    @State private var directory = ShopDirectoryViewModel()
    @State private var locationManager = LocationManager()

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            PersistedShop.self,
            RecentlyViewedShop.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(directory)
                .environment(locationManager)
        }
        .modelContainer(sharedModelContainer)
    }
}
