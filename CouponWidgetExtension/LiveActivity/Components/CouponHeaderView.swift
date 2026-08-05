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

    var body: some View {

        HStack(alignment: .top) {

            VStack(
                alignment: .leading,
                spacing: ActivitySpacing.xxSmall
            ) {

                Text(merchantName)
                    .font(ActivityFonts.merchant)
                    .foregroundStyle(ActivityColors.primaryText)

                Text(couponTitle)
                    .font(ActivityFonts.couponTitle)
                    .foregroundStyle(ActivityColors.secondaryText)
            }

            Spacer()

            CouponDiscountBadgeView(
                discount: discount
            )
        }
    }
}
