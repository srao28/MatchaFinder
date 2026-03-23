//
//  ExploreView.swift
//  MatchaFinder
//

import SwiftUI

struct ExploreView: View {
    @Environment(ShopDirectoryViewModel.self) private var directory
    @Environment(LocationManager.self) private var location

    var body: some View {
        @Bindable var directory = directory
        NavigationStack {
            List {
                ForEach(directory.filteredShops()) { shop in
                    NavigationLink(value: shop) {
                        ShopRowView(
                            shop: shop,
                            distanceText: directory.distanceLabel(for: shop, user: location.userCoordinate)
                        )
                    }
                }
            }
            .navigationTitle("Explore")
            .navigationDestination(for: MatchaShop.self) { shop in
                ShopDetailView(shop: shop)
            }
            .searchable(text: $directory.filterText, prompt: "Search mock shops")
            .scrollContentBackground(.hidden)
            .background(MatchaTheme.secondary)
        }
    }
}

#Preview {
    ExploreView()
        .environment(ShopDirectoryViewModel())
        .environment(LocationManager())
}
