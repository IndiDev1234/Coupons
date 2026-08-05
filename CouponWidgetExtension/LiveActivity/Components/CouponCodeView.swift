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
            spacing: ActivitySpacing.xSmall
        ) {

            Text("Coupon Code")
                .font(ActivityFonts.caption)
                .foregroundStyle(ActivityColors.secondaryText)

            Text(couponCode)
                .font(.title3.monospaced())
                .foregroundStyle(ActivityColors.primaryText)
                .padding(.horizontal, ActivitySpacing.medium)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(
                        cornerRadius: ActivityRadius.medium,
                        style: .continuous
                    )
                    .fill(.thinMaterial)
                )
        }
    }
}
