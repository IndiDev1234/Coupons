//
//  NearbyCouponEngine.swift
//

import Foundation

@MainActor
final class NearbyCouponEngine: NearbyCouponEngineProtocol {

    private let merchantLocationService: MerchantLocationServiceProtocol

    init(
        merchantLocationService: MerchantLocationServiceProtocol
    ) {

        self.merchantLocationService = merchantLocationService
    }

    func nearbyCoupons(
        from coupons: [Coupon]
    ) async throws -> [NearbyCoupon] {

        var results: [NearbyCoupon] = []

        for coupon in coupons {

            print("")
            print("🔍 Processing:", coupon.title)

            guard let merchantName = coupon.merchant?.name,
                  !merchantName.isEmpty else {

                print("❌ Merchant missing")

                continue
            }

            print("🏪 Merchant:", merchantName)

            let stores = try await merchantLocationService.searchNearbyStores(
                merchantName: merchantName
            )

            print("📍 Found", stores.count, "stores")

            guard let nearestStore = stores.first else {

                print("❌ No nearby stores")

                continue
            }

            print("✅ Match:", nearestStore.name)
            print("📏 Distance:", Int(nearestStore.distance))

            results.append(
                NearbyCoupon(
                    coupon: coupon,
                    merchantLocation: nearestStore
                )
            )
        }

        return results.sorted {

            $0.distance < $1.distance
        }
    }
}
