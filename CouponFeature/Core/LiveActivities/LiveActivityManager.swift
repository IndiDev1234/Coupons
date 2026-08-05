//
//  LiveActivityManager.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 05/08/26.
//

import Foundation
import ActivityKit
import os

@MainActor
final class LiveActivityManager {

    static let shared = LiveActivityManager()

    private init() {}

    private var currentActivity: Activity<CouponActivityAttributes>?

    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? "test.CouponFeature",
        category: "CouponLiveActivity"
    )
}

// MARK: - Public API

extension LiveActivityManager {

    func startMockCoupon() async {

        guard ActivityAuthorizationInfo().areActivitiesEnabled else {
            logger.warning("⚠️ Live Activities are disabled in system settings.")
            return
        }

        let attributes = CouponActivityAttributes(
            couponID: UUID()
        )

        let state = CouponActivityAttributes.ContentState(
            merchantName: "Starbucks",
            couponTitle: "Summer Special",
            discountText: "25% OFF",
            couponCode: "STAR25",
            distance: "150 m",
            expiryDate: Calendar.current.date(
                byAdding: .hour,
                value: 4,
                to: .now
            )!,
            status: .active
        )

        do {
            currentActivity = try Activity.request(
                attributes: attributes,
                content: .init(
                    state: state,
                    staleDate: nil
                ),
                pushType: nil
            )

            logger.log("""
            
            ┌────────────────────────────────────────┐
            │       🚀 LIVE ACTIVITY STARTED         │
            ├────────────────────────────────────────┤
            │ ID:       \(self.currentActivity?.id ?? "nil")
            │ Merchant: \(state.merchantName)
            │ Coupon:   \(state.couponTitle)
            │ Discount: \(state.discountText)
            │ Code:     \(state.couponCode)
            │ Status:   \(state.status.rawValue.uppercased())
            └────────────────────────────────────────┘
            """)

        } catch {
            logger.error("❌ Live Activity Start Error: \(error.localizedDescription)")
        }
    }

    func updateCoupon() async {

        guard let activity = currentActivity else { return }

        let updatedState = CouponActivityAttributes.ContentState(
            merchantName: "Starbucks",
            couponTitle: "Summer Special",
            discountText: "40% OFF",
            couponCode: "STAR40",
            distance: "50 m",
            expiryDate: Calendar.current.date(
                byAdding: .hour,
                value: 2,
                to: .now
            )!,
            status: .expiringSoon
        )

        await activity.update(
            .init(
                state: updatedState,
                staleDate: nil
            )
        )

        logger.log("""
        
        ┌────────────────────────────────────────┐
        │       🔄 LIVE ACTIVITY UPDATED         │
        ├────────────────────────────────────────┤
        │ ID:       \(activity.id)
        │ Merchant: \(updatedState.merchantName)
        │ Discount: \(updatedState.discountText)
        │ Code:     \(updatedState.couponCode)
        │ Distance: \(updatedState.distance)
        │ Status:   \(updatedState.status.rawValue.uppercased())
        └────────────────────────────────────────┘
        """)
    }

    func endCoupon() async {

        guard let activity = currentActivity else { return }

        await activity.end(
            nil,
            dismissalPolicy: .immediate
        )

        logger.log("""
        
        ┌────────────────────────────────────────┐
        │       🛑 LIVE ACTIVITY ENDED           │
        ├────────────────────────────────────────┤
        │ ID:       \(activity.id)
        └────────────────────────────────────────┘
        """)

        currentActivity = nil
    }
}
