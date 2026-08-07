//
//  AppContainer.swift
//  CouponFeature
//

import Foundation
import Observation
import SwiftData

@Observable
@MainActor
final class AppContainer {

    static let shared = AppContainer()

    // MARK: - Core

    let locationService: LocationService

    let merchantLocationService: MerchantLocationService

    let nearbyCouponEngine: NearbyCouponEngine

    let locationMonitor: CouponLocationMonitor

    // MARK: - Managers

    let couponActivityManager: CouponActivityManager

    let automationManager: CouponAutomationManager

    private init() {

        let modelContext = PersistenceController.shared
            .modelContainer
            .mainContext

        // Services

        locationService = LocationService()

        merchantLocationService = MerchantLocationService(
            locationService: locationService
        )

        nearbyCouponEngine = NearbyCouponEngine(
            merchantLocationService: merchantLocationService
        )

        locationMonitor = CouponLocationMonitor(
            locationService: locationService
        )

        // Managers

        couponActivityManager = CouponActivityManager.shared

        automationManager = CouponAutomationManager(
            modelContext: modelContext,
            locationMonitor: locationMonitor,
            nearbyCouponEngine: nearbyCouponEngine,
            activityManager: couponActivityManager
        )
    }

    func start() {

        automationManager.start()
    }
}
