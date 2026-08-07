//
//  CouponStatusBadge.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//


//
//  CouponStatusBadge.swift
//

import SwiftUI

struct CouponStatusBadge: View {

    let status: CouponStatus

    var body: some View {

        Text(title)
            .font(.caption.bold())
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(color.opacity(0.15))
            .foregroundStyle(color)
            .clipShape(Capsule())
    }
}

private extension CouponStatusBadge {

    var title: String {

        switch status {

        case .active:
            return "ACTIVE"

        case .expiringSoon:
            return "EXPIRING"

        case .expired:
            return "EXPIRED"

        case .redeemed:
            return "USED"
        }
    }

    var color: Color {

        switch status {

        case .active:
            return .green

        case .expiringSoon:
            return .orange

        case .expired:
            return .red

        case .redeemed:
            return .gray
        }
    }
}