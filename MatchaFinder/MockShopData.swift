//
//  MockShopData.swift
//  MatchaFinder
//

import Foundation

enum MockShopData {
    /// Hardcoded matcha spots around San Francisco for map + lists (iteration 1).
    static let shops: [MatchaShop] = [
        MatchaShop(
            placeId: "mock-001",
            name: "Foggy Leaf Matcha",
            address: "428 Hayes St, San Francisco, CA",
            latitude: 37.7767,
            longitude: -122.4230,
            rating: 4.7,
            hoursSummary: "8am–6pm daily"
        ),
        MatchaShop(
            placeId: "mock-002",
            name: "Mission Ceremonial Bar",
            address: "2200 Mission St, San Francisco, CA",
            latitude: 37.7614,
            longitude: -122.4195,
            rating: 4.5,
            hoursSummary: "9am–8pm, closed Mon"
        ),
        MatchaShop(
            placeId: "mock-003",
            name: "North Beach Whisk & Whisk",
            address: "550 Columbus Ave, San Francisco, CA",
            latitude: 37.7999,
            longitude: -122.4100,
            rating: 4.8,
            hoursSummary: "7am–7pm daily"
        ),
        MatchaShop(
            placeId: "mock-004",
            name: "Sunset Jade Tea Studio",
            address: "1800 Irving St, San Francisco, CA",
            latitude: 37.7635,
            longitude: -122.4789,
            rating: 4.4,
            hoursSummary: "10am–6pm, closed Tue"
        ),
        MatchaShop(
            placeId: "mock-005",
            name: "Embarcadero Matcha Kiosk",
            address: "1 Ferry Building, San Francisco, CA",
            latitude: 37.7955,
            longitude: -122.3937,
            rating: 4.2,
            hoursSummary: "7am–4pm weekdays"
        ),
    ]

    static func shop(placeId: String) -> MatchaShop? {
        shops.first { $0.placeId == placeId }
    }
}
