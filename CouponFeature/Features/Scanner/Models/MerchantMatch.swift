//
//  MerchantMatch.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import Foundation

struct MerchantMatch {

    /// Canonical merchant name used throughout the app.
    let name: String

    /// OCR/AI text that matched.
    let matchedAlias: String

    /// Confidence between 0 and 1.
    let confidence: Double

    /// Merchant category if known.
    let category: MerchantCategory?
}
