//
//  CouponSortOption.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import Foundation

enum CouponSortOption: String, CaseIterable, Identifiable {

    case newest
    case expiry
    case merchant
    case highestDiscount

    var id: String { rawValue }

    var title: String {

        switch self {

        case .newest:
            return "Newest"

        case .expiry:
            return "Expiring Soon"

        case .merchant:
            return "Merchant"

        case .highestDiscount:
            return "Highest Discount"
        }
    }

    var systemImage: String {

        switch self {

        case .newest:
            return "clock"

        case .expiry:
            return "calendar"

        case .merchant:
            return "building.2"

        case .highestDiscount:
            return "tag"
        }
    }
}
