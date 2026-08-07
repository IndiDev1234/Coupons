//
//  NearbyCouponEngine.swift
//  CouponFeature
//

import Foundation

@MainActor
final class NearbyCouponEngine: NearbyCouponEngineProtocol {

    // MARK: - Dependencies

    private let merchantLocationService: MerchantLocationServiceProtocol

    // MARK: - Init

    init(
        merchantLocationService: MerchantLocationServiceProtocol
    ) {
        self.merchantLocationService = merchantLocationService
    }

    // MARK: - Public

    func nearbyCoupons(
        from coupons: [Coupon]
    ) async throws -> [NearbyCoupon] {

        var results: [NearbyCoupon] = []

        print("")
        print("═══════════════════════════════════════")
        print("📦 TOTAL COUPONS:", coupons.count)
        print("═══════════════════════════════════════")

        for coupon in coupons {

            // Ignore redeemed coupons
            if coupon.isRedeemed {

                print("⏭️ Skipping redeemed coupon:", coupon.title)
                continue
            }

            // Ignore expired coupons
            if let expiry = coupon.expiryDate,
               expiry < .now {

                print("⏭️ Skipping expired coupon:", coupon.title)
                continue
            }

            guard let merchantName = coupon.merchant?.name,
                  !merchantName.isEmpty else {

                print("❌ Missing merchant for:", coupon.title)
                continue
            }

            print("")
            print("🔍 Processing:", coupon.title)
            print("🏪 Merchant:", merchantName)

            let stores = try await merchantLocationService.searchNearbyStores(
                merchantName: merchantName
            )

            print("📍 Found \(stores.count) stores")

            guard let nearestStore = stores.first else {

                print("❌ No nearby stores found")
                continue
            }

            let nearbyCoupon = NearbyCoupon(
                coupon: coupon,
                merchantLocation: nearestStore
            )

            print("✅ Store:", nearestStore.name)
            print("📏 Distance:", nearbyCoupon.distanceText)
            print("⭐ Priority:", nearbyCoupon.priority)

            if nearbyCoupon.isWithinTriggerRadius {

                print("🟢 Within Trigger Radius")
            } else {

                print("⚪ Outside Trigger Radius")
            }

            results.append(nearbyCoupon)
        }

        results.sort {

            if $0.priority != $1.priority {

                return $0.priority < $1.priority
            }

            return $0.distance < $1.distance
        }

        print("")
        print("═══════════════════════════════════════")
        print("🎟 VALID NEARBY COUPONS:", results.count)
        print("═══════════════════════════════════════")

        return results
    }
}
