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

        CouponCardView(status: context.state.status) {
            CouponHeaderView(
                merchantName: context.state.merchantName,
                couponTitle: context.state.couponTitle,
                discount: context.state.discountText,
                status: context.state.status
            )
        } stub: {
            CouponCodeView(
                code: context.state.couponCode
            )

            CouponFooterView(
                distance: context.state.distance,
                expiryDate: context.state.expiryDate
            )
        }
    }
}
