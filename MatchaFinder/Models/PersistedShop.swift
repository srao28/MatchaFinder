//
//  PersistedShop.swift
//  MatchaFinder
//

import Foundation
import SwiftData

/// One row per `placeId`: favorite flag via `favoriteSavedAt`, optional 1–5 user rating.
@Model
final class PersistedShop {
    @Attribute(.unique) var placeId: String
    var favoriteSavedAt: Date?
    var userStarRating: Int?

    init(placeId: String, favoriteSavedAt: Date? = nil, userStarRating: Int? = nil) {
        self.placeId = placeId
        self.favoriteSavedAt = favoriteSavedAt
        self.userStarRating = userStarRating
    }

    var isFavorite: Bool { favoriteSavedAt != nil }
}
