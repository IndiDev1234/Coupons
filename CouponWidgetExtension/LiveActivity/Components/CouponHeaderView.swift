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

        VStack(
            alignment: .leading,
            spacing: ActivitySpacing.xSmall
        ) {

            HStack(alignment: .top) {

                Text(merchantName)
                    .font(ActivityFonts.merchant)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .layoutPriority(1)

                Spacer(minLength: 12)

                CouponDiscountBadgeView(
                    discount: discount
                )
            }

            Text(couponTitle)
                .font(ActivityFonts.couponTitle)
                .foregroundStyle(.secondary)
                .lineLimit(2)
        }
    }
}
