//
//  CouponFilter.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//


//
//  CouponFilter.swift
//  CouponFeature
//

import SwiftUI

enum CouponFilter: String, CaseIterable, Identifiable {

    case all
    case active
    case favorites
    case expiring
    case redeemed
    case nearby

    var id: Self { self }
}

extension CouponFilter {

    var title: String {

        switch self {

        case .all:
            return "All"

        case .active:
            return "Active"

        case .favorites:
            return "Favorites"

        case .expiring:
            return "Expiring"

        case .redeemed:
            return "Redeemed"

        case .nearby:
            return "Nearby"
        }
    }

    var icon: String {

        switch self {

        case .all:
            return "square.grid.2x2"

        case .active:
            return "checkmark.seal.fill"

        case .favorites:
            return "heart.fill"

        case .expiring:
            return "clock.fill"

        case .redeemed:
            return "checkmark.circle.fill"

        case .nearby:
            return "location.fill"
        }
    }

    var tint: Color {

        switch self {

        case .all:
            return .accentColor

        case .active:
            return .green

        case .favorites:
            return .red

        case .expiring:
            return .orange

        case .redeemed:
            return .gray

        case .nearby:
            return .blue
        }
    }
}