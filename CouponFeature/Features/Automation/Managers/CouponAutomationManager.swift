//
//  CouponAutomationManager.swift
//  CouponFeature
//

import Foundation
import SwiftData
import CoreLocation

@MainActor
final class CouponAutomationManager {

    // MARK: Dependencies

    private let locationMonitor: CouponLocationMonitor
    private let nearbyCouponEngine: NearbyCouponEngineProtocol
    private let activityManager: CouponActivityManagerProtocol
    private let modelContext: ModelContext

    // MARK: State

    private var activeCouponID: UUID?
    private var lastNearbyCoupon: NearbyCoupon?
    private var lastUpdateDate: Date?

    // MARK: Init

    init(
        modelContext: ModelContext,
        locationMonitor: CouponLocationMonitor,
        nearbyCouponEngine: NearbyCouponEngineProtocol,
        activityManager: CouponActivityManagerProtocol
    ) {

        self.modelContext = modelContext
        self.locationMonitor = locationMonitor
        self.nearbyCouponEngine = nearbyCouponEngine
        self.activityManager = activityManager

        subscribeToLocation()
    }

    // MARK: Public

    func start() {

        print("🚀 Coupon Automation Started")

        locationMonitor.startMonitoring()
    }

    func stop() {

        print("🛑 Coupon Automation Stopped")

        locationMonitor.stopMonitoring()
    }

    func refresh() async {

        print("")
        print("🔄 Manual Automation Refresh Requested")

        await refreshNearbyCoupons()
    }
}

// MARK: Private

private extension CouponAutomationManager {

    func subscribeToLocation() {

        locationMonitor.onSignificantLocationChange = { [weak self] location in

            guard let self else { return }

            print("")
            print("📍 Significant Location Update")
            print("Latitude : \(location.coordinate.latitude)")
            print("Longitude: \(location.coordinate.longitude)")

            Task {

                await self.refreshNearbyCoupons()
            }
        }
    }

    func refreshNearbyCoupons() async {

        do {

            print("")
            print("🔍 Refreshing Nearby Coupons")

            let descriptor = FetchDescriptor<Coupon>()

            let coupons = try modelContext.fetch(descriptor)

            print("")
            print("📦 Total Coupons:", coupons.count)

            for coupon in coupons {

                print("""
                ------------------------
                🎟 \(coupon.title)
                🏪 Merchant: \(coupon.merchant?.name ?? "nil")
                ID: \(coupon.id)
                ------------------------
                """)
            }

            let nearbyCoupons = try await nearbyCouponEngine.nearbyCoupons(
                from: coupons
            )
            print("🚀 Calling NearbyCouponEngine")
            print("🏪 Nearby Coupons:", nearbyCoupons.count)

            guard let nearest = nearbyCoupons.first else {

                print("❌ No Nearby Coupon Found")

                await endCurrentActivity()

                return
            }

            await handle(nearest)

        } catch {

            print("❌ Automation Error:", error)
        }
    }

    func handle(
        _ nearbyCoupon: NearbyCoupon
    ) async {

        print("")
        print("🏪 Merchant:", nearbyCoupon.coupon.merchant?.name ?? "Unknown")
        print("🎟 Coupon :", nearbyCoupon.coupon.title)
        print("📏 Distance:", nearbyCoupon.distanceText)
        print("🎯 Inside Trigger Radius:", nearbyCoupon.isWithinTriggerRadius)

        guard nearbyCoupon.isWithinTriggerRadius else {

            print("🚶 User is outside trigger radius")

            await endCurrentActivity()

            return
        }

        // Prevent excessive Live Activity updates

        let now = Date()

        if let lastUpdateDate,
           now.timeIntervalSince(lastUpdateDate) < 10 {

            print("⏳ Skipping update (Cooldown)")

            return
        }

        self.lastUpdateDate = now

        // Same coupon already active

        if activeCouponID == nearbyCoupon.coupon.id {

            do {

                print("🔄 Updating Existing Live Activity")

                try await activityManager.update(
                    for: nearbyCoupon.coupon,
                    distance: nearbyCoupon.distanceText
                )

            } catch {

                print("❌ Update Failed:", error)
            }

            return
        }

        print("🛑 Ending Previous Live Activity")

        await endCurrentActivity()

        do {

            print("🚀 Starting Live Activity")

            try await activityManager.start(
                for: nearbyCoupon.coupon,
                distance: nearbyCoupon.distanceText
            )

            activeCouponID = nearbyCoupon.coupon.id
            lastNearbyCoupon = nearbyCoupon

            print("✅ Live Activity Started Successfully")

        } catch {

            print("❌ Failed to Start Live Activity:", error)
        }
    }

    func endCurrentActivity() async {

        guard let activeCouponID else {

            return
        }

        print("🛑 Ending Live Activity")

        await activityManager.end(
            couponID: activeCouponID
        )

        self.activeCouponID = nil
        self.lastNearbyCoupon = nil

        print("✅ Live Activity Ended")
    }

}

