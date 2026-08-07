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

    // MARK: Properties

    private let manager = CLLocationManager()

    private(set) var currentLocation: CLLocation?

    private(set) var authorizationStatus: CLAuthorizationStatus = .notDetermined

    // MARK: Init

    override init() {

        super.init()

        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = 25
    }

    // MARK: Public

    func requestWhenInUseAuthorization() {

        manager.requestWhenInUseAuthorization()
    }

    func startUpdatingLocation() {

        manager.startUpdatingLocation()
    }

    func stopUpdatingLocation() {

        manager.stopUpdatingLocation()
    }
}

// MARK: CLLocationManagerDelegate

extension LocationService: CLLocationManagerDelegate {

    func locationManagerDidChangeAuthorization(
        _ manager: CLLocationManager
    ) {

        authorizationStatus = manager.authorizationStatus

        switch authorizationStatus {

        case .authorizedAlways,
             .authorizedWhenInUse:

            manager.startUpdatingLocation()

        default:

            break
        }
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {

        currentLocation = locations.last

        print("📍 New Location:", currentLocation!)
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {

        print("📍 Location Error:", error.localizedDescription)
    }
}
