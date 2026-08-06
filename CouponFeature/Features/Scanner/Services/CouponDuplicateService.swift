//
//  CouponDuplicateService.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import Foundation
import SwiftData

protocol CouponDuplicateServiceProtocol {

    func existingCoupon(
        title: String,
        code: String?,
        merchant: String,
        context: ModelContext
    ) throws -> Coupon?
}

final class CouponDuplicateService: CouponDuplicateServiceProtocol {

    func existingCoupon(
        title: String,
        code: String?,
        merchant: String,
        context: ModelContext
    ) throws -> Coupon? {

        let descriptor = FetchDescriptor<Coupon>()

        let coupons = try context.fetch(descriptor)

        return coupons.first {

            let sameMerchant =
                ($0.merchant?.name ?? "")
                    .localizedCaseInsensitiveCompare(merchant) == .orderedSame

            let sameTitle =
                $0.title
                    .localizedCaseInsensitiveCompare(title) == .orderedSame

            let sameCode =
                ($0.couponCode ?? "")
                    .localizedCaseInsensitiveCompare(code ?? "") == .orderedSame

            return sameMerchant &&
                   (sameCode || sameTitle)
        }
    }
}
