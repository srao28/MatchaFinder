//
//  ShopDetailView.swift
//  MatchaFinder
//

import SwiftData
import SwiftUI

struct ShopDetailView: View {
    let shop: MatchaShop

    @Query private var rows: [PersistedShop]

    @Environment(ShopDirectoryViewModel.self) private var directory
    @Environment(\.modelContext) private var modelContext

    init(shop: MatchaShop) {
        self.shop = shop
        let pid = shop.placeId
        _rows = Query(filter: #Predicate<PersistedShop> { $0.placeId == pid })
    }

    private var persisted: PersistedShop? { rows.first }
    private var isFavorite: Bool { persisted?.favoriteSavedAt != nil }
    private var userStars: Int? { persisted?.userStarRating }

    private var shareText: String {
        "\(shop.name)\n\(shop.address)"
    }

    var body: some View {
        List {
            Section {
                HStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(MatchaTheme.primary.opacity(0.2))
                        .frame(height: 120)
                        .overlay {
                            Image(systemName: "photo")
                                .font(.largeTitle)
                                .foregroundStyle(MatchaTheme.primary)
                        }
                }
                .listRowBackground(Color.clear)

                LabeledContent("Address") {
                    Text(shop.address)
                        .multilineTextAlignment(.trailing)
                }
                LabeledContent("Hours") {
                    Text(shop.hoursSummary)
                }
                LabeledContent("Rating") {
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(MatchaTheme.primary)
                        Text(String(format: "%.1f", shop.rating))
                    }
                }
            }

            Section("Your rating") {
                UserStarRow(shop: shop, current: userStars)
            }

            Section {
                Button {
                    directory.toggleFavorite(for: shop, modelContext: modelContext)
                } label: {
                    if isFavorite {
                        Label("Remove from favorites", systemImage: "heart.slash")
                    } else {
                        Label("Add to favorites", systemImage: "heart.fill")
                    }
                }
                .tint(MatchaTheme.primary)

                ShareLink(
                    item: shareText,
                    subject: Text(shop.name),
                    message: Text(shop.address)
                )
                .tint(MatchaTheme.primary)
            }
        }
        .navigationTitle(shop.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            directory.recordRecentlyViewed(shop: shop, modelContext: modelContext)
        }
    }
}

private struct UserStarRow: View {
    let shop: MatchaShop
    let current: Int?

    @Environment(ShopDirectoryViewModel.self) private var directory
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                ForEach(1 ... 5, id: \.self) { star in
                    Button {
                        let next = (current == star) ? nil : star
                        directory.setUserRating(for: shop, stars: next, modelContext: modelContext)
                    } label: {
                        Image(systemName: star <= (current ?? 0) ? "star.fill" : "star")
                            .font(.title2)
                            .foregroundStyle(MatchaTheme.primary)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Rate \(star) stars")
                }
            }
            if current == nil {
                Text("Tap a star to save; tap again on the same star to clear.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationStack {
        ShopDetailView(shop: MockShopData.shops[0])
    }
    .modelContainer(for: [PersistedShop.self, RecentlyViewedShop.self], inMemory: true)
    .environment(ShopDirectoryViewModel())
}
