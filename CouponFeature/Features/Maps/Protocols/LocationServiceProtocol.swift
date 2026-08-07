//
//  LocationServiceProtocol.swift
//  CouponFeature
//

import Foundation
import CoreLocation

@MainActor
protocol LocationServiceProtocol: AnyObject {

    var authorizationStatus: CLAuthorizationStatus { get }

    var currentLocation: CLLocation? { get }

    func requestWhenInUseAuthorization()

    func startUpdatingLocation()

    func stopUpdatingLocation()
}
