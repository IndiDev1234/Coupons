//
//  CouponDuplicateService.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import Foundation

final class CouponDuplicateService: CouponDuplicateServiceProtocol {

    func findDuplicate(
        for draft: CouponDraft,
        in coupons: [Coupon]
    ) -> DuplicateMatch? {

        var bestMatch: DuplicateMatch?

        for coupon in coupons {

            var score = 0
            var reasons: [DuplicateReason] = []

            // MARK: Coupon Code

            if let couponCode = coupon.couponCode,
               !draft.couponCode.isEmpty,
               draft.couponCode.localizedCaseInsensitiveCompare(couponCode) == .orderedSame {

                score += 70
                reasons.append(.couponCode)
            }

            // MARK: Merchant

            if draft.merchantName.localizedCaseInsensitiveCompare(
                coupon.merchant?.name ?? ""
            ) == .orderedSame {

                score += 15
                reasons.append(.merchant)
            }

            // MARK: Expiry

            if let draftExpiry = draft.expiryDate,
               let couponExpiry = coupon.expiryDate,
               Calendar.current.isDate(
                    draftExpiry,
                    inSameDayAs: couponExpiry
               ) {

                score += 10
                reasons.append(.expiryDate)
            }

            // MARK: Discount

            if let draftDiscount = draft.discountValue,
               let couponDiscount = coupon.discountValue,
               draftDiscount == couponDiscount {

                score += 5
                reasons.append(.discount)
            }

            let match = DuplicateMatch(
                coupon: coupon,
                score: score,
                reasons: reasons
            )

            if match.isDuplicate {

                if let currentBest = bestMatch {

                    if match.score > currentBest.score {
                        bestMatch = match
                    }

                } else {

                    bestMatch = match
                }
            }
        }

        return bestMatch
    }
}
