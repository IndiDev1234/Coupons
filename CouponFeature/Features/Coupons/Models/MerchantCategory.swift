//
//  MerchantCategory.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import Foundation

enum MerchantCategory: String, Codable, CaseIterable {

    case coffee
    case fashion
    case grocery
    case electronics
    case restaurant
    case beauty
    case pharmacy
    case travel
    case entertainment
    case sports
    case other
}
extension MerchantCategory {

    var displayName: String {

        switch self {

        case .coffee:
            return "Coffee"

        case .fashion:
            return "Fashion"

        case .grocery:
            return "Grocery"

        case .electronics:
            return "Electronics"

        case .restaurant:
            return "Restaurant"

        case .beauty:
            return "Beauty"

        case .pharmacy:
            return "Pharmacy"

        case .travel:
            return "Travel"

        case .entertainment:
            return "Entertainment"

        case .sports:
            return "Sports"

        case .other:
            return "Other"
        }
    }
}
