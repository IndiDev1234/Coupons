//
//  CouponHeaderView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 05/08/26.
//


import SwiftUI
import ActivityKit

struct CouponHeaderView: View {

    let merchantName: String
    let couponTitle: String

    var body: some View {

        VStack(alignment: .leading,
               spacing: ActivitySpacing.xxSmall) {

            Text(merchantName)
                .font(ActivityFonts.merchant)
                .foregroundStyle(ActivityColors.primaryText)
                .lineLimit(1)

            Text(couponTitle)
                .font(ActivityFonts.couponTitle)
                .foregroundStyle(ActivityColors.secondaryText)
                .lineLimit(2)
        }
    }
}
