//
//  MatchaShop.swift
//  MatchaFinder
//

import CoreLocation
import Foundation

struct MatchaShop: Identifiable, Hashable {
    let placeId: String
    let name: String
    let address: String
    let latitude: Double
    let longitude: Double
    /// Mock “venue” rating (e.g. Google-style), not the user’s stars.
    let rating: Double
    let hoursSummary: String

    var id: String { placeId }

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
