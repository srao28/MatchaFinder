//
//  RecentlyViewedShop.swift
//  MatchaFinder
//

import Foundation
import SwiftData

@Model
final class RecentlyViewedShop {
    @Attribute(.unique) var placeId: String
    var viewedAt: Date

    init(placeId: String, viewedAt: Date = .now) {
        self.placeId = placeId
        self.viewedAt = viewedAt
    }
}
