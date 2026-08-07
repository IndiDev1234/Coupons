//
//  MerchantLocation.swift
//

import Foundation
import CoreLocation
import MapKit

struct MerchantLocation: Identifiable {

    let id = UUID()

    let name: String

    let address: String

    let latitude: Double

    let longitude: Double

    let distance: CLLocationDistance

    let mapItem: MKMapItem

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude
        )
    }
}
