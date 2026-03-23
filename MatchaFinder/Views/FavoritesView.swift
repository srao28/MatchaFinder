//
//  FavoritesView.swift
//  MatchaFinder
//

import SwiftData
import SwiftUI

struct FavoritesView: View {
    @Environment(ShopDirectoryViewModel.self) private var directory
    @Environment(LocationManager.self) private var location
    @Environment(\.modelContext) private var modelContext

    @Query(sort: \PersistedShop.placeId) private var persistedRows: [PersistedShop]

    private var favoriteRows: [PersistedShop] {
        persistedRows
            .filter { $0.favoriteSavedAt != nil }
            .sorted {
                ($0.favoriteSavedAt ?? .distantPast) > ($1.favoriteSavedAt ?? .distantPast)
            }
    }

    var body: some View {
        NavigationStack {
            Group {
                if favoriteRows.isEmpty {
                    ContentUnavailableView(
                        "No favorites yet",
                        systemImage: "heart",
                        description: Text("Save shops from Explore or the map.")
                    )
                } else {
                    List {
                        ForEach(favoriteRows, id: \.placeId) { row in
                            if let shop = MockShopData.shop(placeId: row.placeId) {
                                NavigationLink(value: shop) {
                                    ShopRowView(
                                        shop: shop,
                                        distanceText: directory.distanceLabel(
                                            for: shop,
                                            user: location.userCoordinate
                                        )
                                    )
                                }
                            }
                        }
                        .onDelete(perform: deleteFavorites)
                    }
                    .scrollContentBackground(.hidden)
                    .background(MatchaTheme.secondary)
                }
            }
            .navigationTitle("Favorites")
            .navigationDestination(for: MatchaShop.self) { shop in
                ShopDetailView(shop: shop)
            }
        }
    }

    private func deleteFavorites(at offsets: IndexSet) {
        for i in offsets {
            directory.removeFromFavorites(favoriteRows[i], modelContext: modelContext)
        }
    }
}

#Preview {
    FavoritesView()
        .modelContainer(for: [PersistedShop.self, RecentlyViewedShop.self], inMemory: true)
        .environment(ShopDirectoryViewModel())
        .environment(LocationManager())
}
