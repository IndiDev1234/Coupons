//
//  DiscountType.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import Foundation

enum DiscountType: String, Codable, CaseIterable {

    case percentage
    case fixedAmount
    case freeItem
}
