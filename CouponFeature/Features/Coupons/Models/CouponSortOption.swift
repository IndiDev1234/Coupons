//
//  CouponSortOption.swift
//

import Foundation

enum CouponSortOption: String, CaseIterable, Identifiable {

    case newest
    case oldest
    case expiry
    case merchant
    case highestDiscount

    var id: String { rawValue }

    var title: String {

        switch self {

        case .newest:
            return "Newest"

        case .oldest:
            return "Oldest"

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

        case .oldest:
            return "clock.arrow.circlepath"

        case .expiry:
            return "calendar"

        case .merchant:
            return "building.2"

        case .highestDiscount:
            return "tag"
        }
    }
}
