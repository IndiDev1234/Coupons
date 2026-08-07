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
        print("══════════════════════════════════════════════")
        print("🔍 MerchantLocationService Started")
        print("🏪 Searching Merchant:", merchantName)
        print("══════════════════════════════════════════════")

        guard let userLocation = locationService.currentLocation else {

            print("❌ Current Location is nil")
            print("══════════════════════════════════════════════")

            return []
        }

        print("""
        📍 Current User Location
        Latitude : \(userLocation.coordinate.latitude)
        Longitude: \(userLocation.coordinate.longitude)
        Accuracy : ±\(Int(userLocation.horizontalAccuracy))m
        """)

        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = merchantName

        request.region = MKCoordinateRegion(
            center: userLocation.coordinate,
            latitudinalMeters: 10_000,
            longitudinalMeters: 10_000
        )

        print("")
        print("🍎 Sending Apple Maps Search Request...")

        let response: MKLocalSearch.Response

        do {

            response = try await MKLocalSearch(
                request: request
            ).start()

        } catch {

            print("❌ Apple Maps Search Failed")
            print(error.localizedDescription)
            print("══════════════════════════════════════════════")

            throw error
        }

        print("✅ Apple Maps Search Completed")
        print("🍎 Results Found:", response.mapItems.count)

        if response.mapItems.isEmpty {

            print("⚠️ No stores returned for '\(merchantName)'")
            print("══════════════════════════════════════════════")
        }

        let stores = response.mapItems.map { item in

            let location = item.location
            let coordinate = location.coordinate

            let distance = userLocation.distance(from: location)

            let address = item.address?.description ?? "Unknown Address"

            print("""
            ----------------------------------------
            🏪 Store Name
            \(item.name ?? merchantName)

            📍 Address
            \(address)

            🌍 Latitude
            \(coordinate.latitude)

            🌍 Longitude
            \(coordinate.longitude)

            📏 Distance
            \(Int(distance)) meters
            ----------------------------------------
            """)

            return MerchantLocation(
                name: item.name ?? merchantName,
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
            print("🎯 Nearest Store Selected")
            print("🏪 \(nearest.name)")
            print("📍 \(nearest.address)")
            print("📏 \(Int(nearest.distance))m")
        } else {

            print("⚠️ No nearest store available")
        }

        print("")
        print("✅ MerchantLocationService Finished")
        print("📦 Returning \(stores.count) nearby stores")
        print("══════════════════════════════════════════════")

        return stores
    }
}
