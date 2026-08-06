//
//  AICouponResult.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//


import Foundation

struct AICouponResult: Codable {

    var merchant: String?

    var couponTitle: String?

    var couponCode: String?

    var discountValue: Double?

    var discountType: DiscountType?

    var minimumPurchase: Double?

    var expiryDate: String?

    var termsSummary: [String]

    var category: MerchantCategory?

    var confidence: Double

    var rawOCR: String

    init(
        merchant: String? = nil,
        couponTitle: String? = nil,
        couponCode: String? = nil,
        discountValue: Double? = nil,
        discountType: DiscountType? = nil,
        minimumPurchase: Double? = nil,
        expiryDate: String? = nil,
        termsSummary: [String] = [],
        category: MerchantCategory? = nil,
        confidence: Double = 0,
        rawOCR: String = ""
    ) {

        self.merchant = merchant
        self.couponTitle = couponTitle
        self.couponCode = couponCode
        self.discountValue = discountValue
        self.discountType = discountType
        self.minimumPurchase = minimumPurchase
        self.expiryDate = expiryDate
        self.termsSummary = termsSummary
        self.category = category
        self.confidence = confidence
        self.rawOCR = rawOCR
    }
}
