//
//  DuplicateMatch.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//

import Foundation

struct DuplicateMatch {

    let coupon: Coupon

    let score: Int

    let reasons: [DuplicateReason]

    var isDuplicate: Bool {

        score >= 80
    }
}
