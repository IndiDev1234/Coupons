//
//  CouponLocationMonitor.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//


//
//  CouponLocationMonitor.swift
//  CouponFeature
//

import Foundation
import CoreLocation

@MainActor
final class CouponLocationMonitor {

    // MARK: - Properties

    private let locationService: LocationServiceProtocol

    /// Minimum movement before notifying listeners
    private let minimumDistance: CLLocationDistance = 50

    private var previousLocation: CLLocation?

    /// Called whenever a meaningful location change occurs
    var onSignificantLocationChange: ((CLLocation) -> Void)?

    // MARK: - Init

    init(
        locationService: LocationServiceProtocol
    ) {

        self.locationService = locationService

        observeLocationUpdates()
    }

    // MARK: - Public

    func startMonitoring() {

        locationService.requestWhenInUseAuthorization()
        locationService.startUpdatingLocation()
    }

    func stopMonitoring() {

        locationService.stopUpdatingLocation()
    }
}

// MARK: - Private

private extension CouponLocationMonitor {

    func observeLocationUpdates() {

        locationService.onLocationChanged = { [weak self] location in

            guard let self else {

                return
            }

            handleLocation(location)
        }
    }

    func handleLocation(
        _ location: CLLocation
    ) {

        guard let previousLocation else {

            self.previousLocation = location

            onSignificantLocationChange?(location)

            print("📍 Initial Location Received")

            return
        }

        let distance = location.distance(
            from: previousLocation
        )

        guard distance >= minimumDistance else {

            print(
                "📍 Ignoring movement (\(Int(distance))m)"
            )

            return
        }

        self.previousLocation = location

        print(
            """
            📍 Significant Movement
            Distance: \(Int(distance))m
            """
        )

        onSignificantLocationChange?(location)
    }
}
