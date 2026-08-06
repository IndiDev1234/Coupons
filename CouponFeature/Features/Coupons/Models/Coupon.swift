//
//  Coupon.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import Foundation
import SwiftData

@Model
final class Coupon {

    @Attribute(.unique)
    var id: UUID

    var title: String

    var couponCode: String?

    var discountValue: Double?

    var discountType: DiscountType

    var minimumPurchase: Double?

    var expiryDate: Date?

    var termsAndConditions: String?

    var notes: String?

    var isFavorite: Bool

    var isRedeemed: Bool

    var createdAt: Date

    var updatedAt: Date

    init(
        id: UUID = UUID(),
        title: String,
        couponCode: String? = nil,
        discountValue: Double? = nil,
        discountType: DiscountType,
        minimumPurchase: Double? = nil,
        expiryDate: Date? = nil,
        termsAndConditions: String? = nil,
        notes: String? = nil,
        isFavorite: Bool = false,
        isRedeemed: Bool = false,
        createdAt: Date = .now,
        updatedAt: Date = .now
    ) {

        self.id = id
        self.title = title
        self.couponCode = couponCode
        self.discountValue = discountValue
        self.discountType = discountType
        self.minimumPurchase = minimumPurchase
        self.expiryDate = expiryDate
        self.termsAndConditions = termsAndConditions
        self.notes = notes
        self.isFavorite = isFavorite
        self.isRedeemed = isRedeemed
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
