//
//  LiveActivityManager.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 05/08/26.
//

import Foundation
import ActivityKit

@MainActor
final class LiveActivityManager {

    static let shared = LiveActivityManager()

    private init() {}

    private var currentActivity: Activity<CouponActivityAttributes>?

}

// MARK: - Public API

extension LiveActivityManager {

    func startMockCoupon() async {

        guard ActivityAuthorizationInfo().areActivitiesEnabled else {
            print("❌ Live Activities are disabled.")
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

            print("✅ Live Activity Started")
            print("Started Activity ID:", currentActivity?.id ?? "nil")
            print("Active Activities:", Activity<CouponActivityAttributes>.activities.count)

        } catch {

            print(error.localizedDescription)
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

        print("✅ Live Activity Updated")
    }

    func endCoupon() async {

        guard let activity = currentActivity else { return }

        await activity.end(
            nil,
            dismissalPolicy: .immediate
        )

        currentActivity = nil

        print("🛑 Live Activity Ended")
    }
}
