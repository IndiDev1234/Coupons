//
//  CouponActivityMapper.swift
//

import Foundation

enum CouponActivityMapper {

    static func discountText(
        from coupon: Coupon
    ) -> String {

        guard let value = coupon.discountValue else {
            return "Offer"
        }

        switch coupon.discountType {

        case .percentage:
            return "\(Int(value))% OFF"

        case .fixedAmount:
            return "₹\(Int(value)) OFF"

        case .freeItem:
            return "FREE ITEM"
        }
    }
}
