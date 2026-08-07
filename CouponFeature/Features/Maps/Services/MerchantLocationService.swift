//
//  MerchantLocationService.swift
//  CouponFeature
//

import Foundation
import MapKit
import CoreLocation

final class MerchantLocationService: MerchantLocationServiceProtocol {

    // MARK: - Dependencies

    private let locationService: LocationServiceProtocol

    // MARK: - Init

    init(
        locationService: LocationServiceProtocol
    ) {

        self.locationService = locationService
    }

    // MARK: - Public

    func searchNearbyStores(
        merchantName: String
    ) async throws -> [MerchantLocation] {

        print("")
        print("🔍 Searching Nearby Stores")
        print("🏪 Merchant:", merchantName)

        guard let userLocation = locationService.currentLocation else {

            print("❌ Current location unavailable")

            return []
        }

        print(
        """
        📍 User Location
        Latitude : \(userLocation.coordinate.latitude)
        Longitude: \(userLocation.coordinate.longitude)
        """
        )

        let request = MKLocalSearch.Request()

        request.naturalLanguageQuery = merchantName

        request.region = MKCoordinateRegion(
            center: userLocation.coordinate,
            latitudinalMeters: 10_000,
            longitudinalMeters: 10_000
        )

        let response = try await MKLocalSearch(
            request: request
        ).start()

        print("🍎 Apple Maps Results:", response.mapItems.count)

        if response.mapItems.isEmpty {

            print("❌ No stores found for \(merchantName)")
        }

        let stores = response.mapItems.map { item in

            let location = item.location
            let coordinate = location.coordinate

            let distance = userLocation.distance(from: location)

            let address = item.address?.description ?? "Unknown Address"

            print(
            """
            -----------------------------
            🏪 Store: \(item.name ?? merchantName)

            📍 Address:
            \(address)

            📏 Distance:
            \(Int(distance))m
            -----------------------------
            """
            )

            return MerchantLocation(
                name: item.name ?? merchantName,
//                address: item.placemark.title ?? "Unknown Address",
                address: address,
                latitude: coordinate.latitude,
                longitude: coordinate.longitude,
                distance: distance,
                mapItem: item
            )
        }
        .sorted {

            $0.distance < $1.distance
        }

        if let nearest = stores.first {

            print("")
            print("✅ Nearest Store Selected")
            print("🏪 \(nearest.name)")
            print("📏 \(Int(nearest.distance))m away")
        }

        return stores
    }
}
