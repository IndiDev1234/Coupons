//
//  CouponLockScreenView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 04/08/26.
//

import SwiftUI
import ActivityKit
import WidgetKit

struct CouponLockScreenView: View {

    let context: ActivityViewContext<CouponActivityAttributes>

    var body: some View {

        CouponCardView {

            CouponHeaderView(
                merchantName: context.state.merchantName,
                couponTitle: context.state.couponTitle,
                discount: context.state.discountText
            )

            Divider()

            CouponCodeView(
                couponCode: context.state.couponCode
            )

            Divider()

            CouponFooterView(
                distance: context.state.distance,
                expiryDate: context.state.expiryDate
            )
        }
        .padding()
    }
}
