//
//  DuplicateCouponError.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//


//
//  DuplicateCouponError.swift
//  CouponFeature
//

import Foundation

struct DuplicateCouponError: LocalizedError {

    let match: DuplicateMatch

    var errorDescription: String? {
        "A similar coupon already exists."
    }
}