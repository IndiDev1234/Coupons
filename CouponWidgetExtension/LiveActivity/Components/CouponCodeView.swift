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
                .font(ActivityFonts.couponCode)
                .foregroundStyle(ActivityColors.primaryText)
                .padding(.horizontal, ActivitySpacing.medium)
                .padding(.vertical, ActivitySpacing.small)
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
