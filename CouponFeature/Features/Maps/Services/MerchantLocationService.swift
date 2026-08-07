//
//  MerchantLocationService.swift
//

import Foundation
import MapKit
import CoreLocation

final class MerchantLocationService: MerchantLocationServiceProtocol {

    private let locationService: LocationServiceProtocol

    init(
        locationService: LocationServiceProtocol
    ) {

        self.locationService = locationService
    }

    func searchNearbyStores(
        merchantName: String
    ) async throws -> [MerchantLocation] {

        guard let userLocation = locationService.currentLocation else {

            return []
        }

        let request = MKLocalSearch.Request()

        request.naturalLanguageQuery = merchantName

        request.region = MKCoordinateRegion(
            center: userLocation.coordinate,
            latitudinalMeters: 10000,
            longitudinalMeters: 10000
        )

        let response = try await MKLocalSearch(
            request: request
        ).start()

        return response.mapItems.map { item in

            let location = item.location
            let coordinate = location.coordinate

            let address = item.name ?? "Unknown Address"

            return MerchantLocation(
                name: item.name ?? merchantName,
                address: address,
                latitude: coordinate.latitude,
                longitude: coordinate.longitude,
                distance: userLocation.distance(from: location),
                mapItem: item
            )
        }
        .sorted {
            $0.distance < $1.distance
        }
    }
}
