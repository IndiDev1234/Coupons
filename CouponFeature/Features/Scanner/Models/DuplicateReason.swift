//
//  DuplicateReason.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//

import Foundation

enum DuplicateReason: String, CaseIterable {

    case couponCode

    case merchant

    case expiryDate

    case discount

    case title
}
