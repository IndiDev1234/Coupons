//
//  ExpandedView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import SwiftUI
import ActivityKit
import WidgetKit

struct ExpandedView: View {

    let context: ActivityViewContext<CouponActivityAttributes>

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: ActivitySpacing.small
        ) {

            CouponHeaderView(
                merchantName: context.state.merchantName,
                couponTitle: context.state.couponTitle,
                discount: context.state.discountText,
            )

            CouponCodeView(
                couponCode: context.state.couponCode
            )

            CouponFooterView(
                distance: context.state.distance,
                expiryDate: context.state.expiryDate
            )
        }
        .padding(.horizontal, ActivitySpacing.small)
        .padding(.vertical, ActivitySpacing.xSmall)
    }
}
