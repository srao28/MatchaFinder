//
//  LocationManager.swift
//  MatchaFinder
//

import CoreLocation
import Foundation
import Observation

@Observable
@MainActor
final class LocationManager: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    var authorizationStatus: CLAuthorizationStatus = .notDetermined
    var userCoordinate: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        authorizationStatus = manager.authorizationStatus
    }

    func requestWhenInUse() {
        manager.requestWhenInUseAuthorization()
    }

    func startUpdatesIfAllowed() {
        guard authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways else {
            return
        }
        manager.startUpdatingLocation()
    }

    nonisolated func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coord = locations.last?.coordinate else { return }
        Task { @MainActor in
            self.userCoordinate = coord
        }
    }

    nonisolated func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        Task { @MainActor in
            self.authorizationStatus = manager.authorizationStatus
            self.startUpdatesIfAllowed()
        }
    }
}
