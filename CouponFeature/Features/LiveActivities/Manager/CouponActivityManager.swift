//
//  CouponActivityManager.swift
//

import Foundation
import ActivityKit

@MainActor
final class CouponActivityManager: CouponActivityManagerProtocol {

    static let shared = CouponActivityManager()

    private init() { }

    // MARK: - Start

    func start(
        for coupon: Coupon
    ) async throws {

        guard ActivityAuthorizationInfo().areActivitiesEnabled else {
            print("❌ Live Activities are disabled.")
            return
        }

        let attributes = CouponActivityAttributes(
            couponID: coupon.id
        )

        let state = CouponActivityAttributes.ContentState(
            merchantName: coupon.merchant?.name ?? "",
            couponTitle: coupon.title,
            discountText: CouponActivityMapper.discountText(from: coupon),
            couponCode: coupon.couponCode ?? "",
            distance: "",
            expiryDate: coupon.expiryDate ?? .now,
            status: couponStatus(for: coupon)
        )

        do {

            let activity = try Activity<CouponActivityAttributes>.request(
                attributes: attributes,
                content: .init(
                    state: state,
                    staleDate: coupon.expiryDate
                )
            )

            print("✅ Started Live Activity:", activity.id)

        } catch {

            print("❌ Failed to start Live Activity:", error)
        }
    }

    // MARK: - Update

    func update(
        for coupon: Coupon
    ) async throws {

        guard let activity = Activity<CouponActivityAttributes>.activities.first(
            where: {
                $0.attributes.couponID == coupon.id
            }
        ) else {

            return
        }

        let state = CouponActivityAttributes.ContentState(
            merchantName: coupon.merchant?.name ?? "",
            couponTitle: coupon.title,
            discountText: CouponActivityMapper.discountText(from: coupon),
            couponCode: coupon.couponCode ?? "",
            distance: "",
            expiryDate: coupon.expiryDate ?? .now,
            status: couponStatus(for: coupon)
        )

        await activity.update(
            .init(
                state: state,
                staleDate: coupon.expiryDate
            )
        )

        print("🔄 Updated Live Activity")
    }

    // MARK: - End

    func end(
        couponID: UUID
    ) async {

        guard let activity = Activity<CouponActivityAttributes>.activities.first(
            where: {
                $0.attributes.couponID == couponID
            }
        ) else {

            return
        }

        await activity.end(
            nil,
            dismissalPolicy: .immediate
        )

        print("🛑 Live Activity Ended")
    }
}

private extension CouponActivityManager {

    func couponStatus(
        for coupon: Coupon
    ) -> CouponStatus {

        if coupon.isRedeemed {
            return .redeemed
        }

        guard let expiry = coupon.expiryDate else {
            return .active
        }

        let calendar = Calendar.current

        if expiry < Date() {
            return .expired
        }

        if calendar.isDateInToday(expiry) {

            return .expiringSoon
        }

        if let tomorrow = calendar.date(
            byAdding: .day,
            value: 1,
            to: Date()
        ),
        expiry <= tomorrow {

            return .expiringSoon
        }

        return .active
    }
}
