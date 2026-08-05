//
//  CouponHeaderView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 05/08/26.
//

import SwiftUI

struct CouponHeaderView: View {

    let merchantName: String
    let couponTitle: String
    let discount: String
    let status: CouponStatus

    private func getAvatarGradient(for status: CouponStatus) -> LinearGradient {
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
        HStack(alignment: .center, spacing: ActivitySpacing.small) {
            // Merchant Initial Circle Avatar with status-tinted premium gradient
            Text(String(merchantName.prefix(1)).uppercased())
                .font(.headline.bold())
                .foregroundStyle(.white)
                .frame(width: 32, height: 32)
                .background(
                    Circle()
                        .fill(getAvatarGradient(for: status))
                )
                .overlay(
                    Circle()
                        .strokeBorder(.white.opacity(0.15), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)

            VStack(alignment: .leading, spacing: 2) {
                HStack(alignment: .center, spacing: ActivitySpacing.xxSmall) {
                    Text(merchantName)
                        .font(ActivityFonts.merchant)
                        .fontWeight(.bold)
                        .foregroundStyle(ActivityColors.primaryText)
                        .lineLimit(1)
                        .layoutPriority(1)

                    CouponStatusBadgeView(status: status)
                }

                Text(couponTitle)
                    .font(ActivityFonts.couponTitle)
                    .foregroundStyle(ActivityColors.secondaryText)
                    .lineLimit(1)
            }

            Spacer(minLength: 8)

            CouponDiscountBadgeView(
                discount: discount
            )
        }
    }
}
