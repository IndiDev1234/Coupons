//
//  CouponActionBar.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//


//
//  CouponActionBar.swift
//  CouponFeature
//

import SwiftUI

struct CouponActionBar: View {

    let coupon: Coupon

    var onFavorite: () -> Void

    var onRedeem: () -> Void

    var onNavigate: () -> Void

    var onShare: () -> Void

    var onReminder: () -> Void

    var body: some View {

        VStack(alignment: .leading, spacing: 20) {

            Text("Actions")
                .font(.headline)

            LazyVGrid(
                columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ],
                spacing: 16
            ) {

                CouponQuickActionButton(
                    title: coupon.isFavorite
                        ? "Favorited"
                        : "Favorite",
                    icon: coupon.isFavorite
                        ? "heart.fill"
                        : "heart",
                    tint: .red,
                    action: onFavorite
                )

                CouponQuickActionButton(
                    title: coupon.isRedeemed
                        ? "Redeemed"
                        : "Redeem",
                    icon: coupon.isRedeemed
                        ? "checkmark.circle.fill"
                        : "checkmark.circle",
                    tint: .green,
                    action: onRedeem
                )

                CouponQuickActionButton(
                    title: "Navigate",
                    icon: "location.fill",
                    tint: .blue,
                    action: onNavigate
                )

                CouponQuickActionButton(
                    title: "Share",
                    icon: "square.and.arrow.up",
                    tint: .orange,
                    action: onShare
                )

                CouponQuickActionButton(
                    title: "Reminder",
                    icon: "bell.badge.fill",
                    tint: .purple,
                    action: onReminder
                )
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(.regularMaterial)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 24
            )
        )
    }
}
