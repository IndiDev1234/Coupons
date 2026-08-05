//
//  CouponStatusBadgeView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 05/08/26.
//

import SwiftUI

struct CouponStatusBadgeView: View {

    let status: CouponStatus

    private var title: String {

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

    private var color: Color {

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

    var body: some View {

        Text(title)
            .font(.caption2.bold())
            .foregroundStyle(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(
                Capsule()
                    .fill(color)
            )
    }
}
