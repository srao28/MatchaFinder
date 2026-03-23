//
//  ContentView.swift
//  MatchaFinder
//

import SwiftData
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ExploreView()
                .tabItem { Label("Explore", systemImage: "leaf.fill") }
            MapBrowseView()
                .tabItem { Label("Map", systemImage: "map") }
            FavoritesView()
                .tabItem { Label("Favorites", systemImage: "heart.fill") }
            SettingsView()
                .tabItem { Label("Settings", systemImage: "gearshape.fill") }
        }
        .tint(MatchaTheme.primary)
        .background(MatchaTheme.secondary)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [PersistedShop.self, RecentlyViewedShop.self], inMemory: true)
        .environment(ShopDirectoryViewModel())
        .environment(LocationManager())
}
