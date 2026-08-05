//
//  CouponCodeView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 05/08/26.
//

import SwiftUI

struct CouponCodeView: View {

    let couponCode: String

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 5
        ) {

            Text("COUPON CODE")
                .font(.system(size: 8, weight: .bold))
                .foregroundStyle(ActivityColors.secondaryText)
                .tracking(1.2)

            HStack(spacing: ActivitySpacing.small) {
                Image(systemName: "barcode.viewfinder")
                    .font(.subheadline)
                    .foregroundStyle(ActivityColors.accent)

                Text(couponCode)
                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                    .foregroundStyle(ActivityColors.primaryText)

                Spacer()

                Image(systemName: "doc.on.doc")
                    .font(.caption)
                    .foregroundStyle(ActivityColors.secondaryText.opacity(0.8))
            }
            .padding(.horizontal, ActivitySpacing.medium)
            .padding(.vertical, 9)
            .background(
                RoundedRectangle(
                    cornerRadius: ActivityRadius.medium,
                    style: .continuous
                )
                .fill(.ultraThinMaterial)
            )
            .overlay(
                RoundedRectangle(
                    cornerRadius: ActivityRadius.medium,
                    style: .continuous
                )
                .strokeBorder(
                    LinearGradient(
                        colors: [.white.opacity(0.2), .clear, .white.opacity(0.05)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1
                )
            )
        }
    }
}
