//
//  ShopDirectoryViewModel.swift
//  MatchaFinder
//

import CoreLocation
import Foundation
import Observation
import SwiftData

@Observable
@MainActor
final class ShopDirectoryViewModel {
    var filterText: String = ""
    let allShops: [MatchaShop] = MockShopData.shops

    func filteredShops() -> [MatchaShop] {
        let q = filterText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !q.isEmpty else { return allShops }
        return allShops.filter {
            $0.name.lowercased().contains(q) || $0.address.lowercased().contains(q)
        }
    }

    func distanceLabel(for shop: MatchaShop, user: CLLocationCoordinate2D?) -> String {
        guard let user else { return "—" }
        let a = CLLocation(latitude: user.latitude, longitude: user.longitude)
        let b = CLLocation(latitude: shop.latitude, longitude: shop.longitude)
        let m = a.distance(from: b)
        if m < 1000 {
            return "\(Int(m)) m"
        }
        return String(format: "%.1f km", m / 1000)
    }

    func persistedShop(placeId: String, modelContext: ModelContext) -> PersistedShop? {
        let id = placeId
        let descriptor = FetchDescriptor<PersistedShop>(predicate: #Predicate { $0.placeId == id })
        return try? modelContext.fetch(descriptor).first
    }

    func isFavorite(placeId: String, modelContext: ModelContext) -> Bool {
        persistedShop(placeId: placeId, modelContext: modelContext)?.isFavorite ?? false
    }

    func userStarRating(placeId: String, modelContext: ModelContext) -> Int? {
        persistedShop(placeId: placeId, modelContext: modelContext)?.userStarRating
    }

    func toggleFavorite(for shop: MatchaShop, modelContext: ModelContext) {
        let id = shop.placeId
        if let row = persistedShop(placeId: id, modelContext: modelContext) {
            if row.isFavorite {
                row.favoriteSavedAt = nil
            } else {
                row.favoriteSavedAt = Date()
            }
        } else {
            let row = PersistedShop(placeId: id, favoriteSavedAt: Date(), userStarRating: nil)
            modelContext.insert(row)
        }
    }

    func setUserRating(for shop: MatchaShop, stars: Int?, modelContext: ModelContext) {
        let id = shop.placeId
        if let row = persistedShop(placeId: id, modelContext: modelContext) {
            row.userStarRating = stars
        } else {
            modelContext.insert(PersistedShop(placeId: id, favoriteSavedAt: nil, userStarRating: stars))
        }
    }

    func recordRecentlyViewed(shop: MatchaShop, modelContext: ModelContext) {
        let id = shop.placeId
        let descriptor = FetchDescriptor<RecentlyViewedShop>(predicate: #Predicate { $0.placeId == id })
        if let row = try? modelContext.fetch(descriptor).first {
            row.viewedAt = Date()
        } else {
            modelContext.insert(RecentlyViewedShop(placeId: id, viewedAt: Date()))
        }
    }

    func removeFromFavorites(_ row: PersistedShop, modelContext: ModelContext) {
        row.favoriteSavedAt = nil
    }
}
