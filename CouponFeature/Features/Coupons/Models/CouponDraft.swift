//
//  CouponDraft.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

//
//  CouponDraft.swift
//  CouponFeature
//

import Foundation

struct CouponDraft: Identifiable {

    var id = UUID()

    var title: String = ""

    var couponCode: String = ""

    var discountValue: Double?

    var discountType: DiscountType = .percentage

    var minimumPurchase: Double?

    var expiryDate: Date?

    var merchantName: String = ""

    var storeName: String = ""

    var termsAndConditions: String = ""

    var notes: String = ""

    var attachments: [String] = []
    
    var aiConfidence: Double?
    
    var extractionSource: CouponExtractionSource = .visionAI
}

enum CouponExtractionSource {

    case visionAI

    case regexFallback

    case manual
}
