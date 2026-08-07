//
//  LocationService.swift
//  CouponFeature
//

import Foundation
import CoreLocation
import Observation

@Observable
@MainActor
final class LocationService: NSObject, LocationServiceProtocol {

    // MARK: - Properties

    private let manager = CLLocationManager()

    private(set) var currentLocation: CLLocation?

    private(set) var authorizationStatus: CLAuthorizationStatus = .notDetermined

    /// Automation layer subscribes here.
    var onLocationChanged: ((CLLocation) -> Void)?

    // MARK: - Init

    override init() {

        super.init()

        manager.delegate = self

        manager.desiredAccuracy = kCLLocationAccuracyBest

        // Ignore tiny GPS movement
        manager.distanceFilter = 25

        // Better battery optimization
        manager.pausesLocationUpdatesAutomatically = true

        // Walking around shops
        manager.activityType = .fitness

        authorizationStatus = manager.authorizationStatus

        // Ask permission on first launch
        if authorizationStatus == .notDetermined {

            manager.requestWhenInUseAuthorization()
        }
    }

    // MARK: - Public

    func requestWhenInUseAuthorization() {

        guard authorizationStatus == .notDetermined else {

            return
        }

        manager.requestWhenInUseAuthorization()
    }

    func startUpdatingLocation() {

        guard authorizationStatus == .authorizedAlways ||
                authorizationStatus == .authorizedWhenInUse else {

            print("❌ Cannot start location updates. Permission missing.")

            return
        }

        print("📍 Starting Location Updates")

        manager.startUpdatingLocation()
    }

    func stopUpdatingLocation() {

        print("🛑 Stopping Location Updates")

        manager.stopUpdatingLocation()
    }
}

// MARK: - CLLocationManagerDelegate

extension LocationService: CLLocationManagerDelegate {

    func locationManagerDidChangeAuthorization(
        _ manager: CLLocationManager
    ) {

        authorizationStatus = manager.authorizationStatus

        switch authorizationStatus {

        case .authorizedAlways,
             .authorizedWhenInUse:

            print("✅ Location Authorized")

            startUpdatingLocation()

        case .denied:

            print("❌ Location Permission Denied")

        case .restricted:

            print("⚠️ Location Restricted")

        case .notDetermined:

            print("⌛ Waiting for Location Permission")

        @unknown default:

            print("⚠️ Unknown Authorization Status")
        }
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {

        guard let location = locations.last else {

            return
        }

        // Ignore invalid GPS fixes
        guard location.horizontalAccuracy >= 0 else {

            return
        }

        // Ignore poor accuracy
        guard location.horizontalAccuracy <= 100 else {

            print("⚠️ Ignoring inaccurate location (±\(Int(location.horizontalAccuracy))m)")

            return
        }

        currentLocation = location

        print(
        """
        📍 New Location
        Latitude : \(location.coordinate.latitude)
        Longitude: \(location.coordinate.longitude)
        Accuracy : ±\(Int(location.horizontalAccuracy))m
        """
        )

        // Notify automation
        onLocationChanged?(location)
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {

        print("❌ Location Error:", error.localizedDescription)
    }
}
