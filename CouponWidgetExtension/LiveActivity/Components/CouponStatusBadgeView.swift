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

    private var gradient: LinearGradient {
        switch status {
        case .active:
            return ActivityColors.successGradient
        case .expiringSoon:
            return ActivityColors.warningGradient
        case .expired:
            return ActivityColors.errorGradient
        case .redeemed:
            return ActivityColors.redeemedGradient
        }
    }

    var body: some View {
        HStack(spacing: 4) {
            Circle()
                .fill(.white.opacity(0.95))
                .frame(width: 4, height: 4)

            Text(title)
                .font(.system(size: 8, weight: .bold))
                .foregroundStyle(.white)
                .tracking(0.5)
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 3)
        .background(
            Capsule()
                .fill(gradient)
        )
        .overlay(
            Capsule()
                .strokeBorder(.white.opacity(0.12), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 0.5)
    }
}
