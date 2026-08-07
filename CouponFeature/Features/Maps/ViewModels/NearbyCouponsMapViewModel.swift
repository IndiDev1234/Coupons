//
//  NearbyCouponsMapViewModel.swift
//  CouponFeature
//

import Foundation
import Observation
import SwiftData

@Observable
@MainActor
final class NearbyCouponsMapViewModel {

    // MARK: State

    private(set) var annotations: [CouponAnnotation] = []

    private(set) var isLoading = false

    var errorMessage: String?

    // MARK: Dependencies

    private let engine: NearbyCouponEngineProtocol

    // MARK: Initializer

    init(
        engine: NearbyCouponEngineProtocol
    ) {

        self.engine = engine
    }

    // MARK: Public

    func loadCoupons(
        using modelContext: ModelContext
    ) async {

        isLoading = true

        defer {

            isLoading = false
        }

        do {

            let descriptor = FetchDescriptor<Coupon>()

            let coupons = try modelContext.fetch(
                descriptor
            )

            let nearbyCoupons = try await engine.nearbyCoupons(
                from: coupons
            )

            annotations = nearbyCoupons.map {

                CouponAnnotation(
                    id: $0.coupon.id,
                    coupon: $0.coupon,
                    merchantLocation: $0.merchantLocation
                )
            }

        } catch {

            errorMessage = error.localizedDescription
        }
    }

    func refresh(
        using modelContext: ModelContext
    ) async {

        await loadCoupons(
            using: modelContext
        )
    }
}
