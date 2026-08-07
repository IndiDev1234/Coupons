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

    /// Automation subscribes here
    var onLocationChanged: ((CLLocation) -> Void)? { get set }

    func requestWhenInUseAuthorization()

    func startUpdatingLocation()

    func stopUpdatingLocation()
}
