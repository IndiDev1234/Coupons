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

        VStack(
            alignment: .leading,
            spacing: ActivitySpacing.medium
        ) {

            CouponHeaderView(
                merchantName: context.state.merchantName,
                couponTitle: context.state.couponTitle
            )

            Divider()

            VStack(alignment: .leading, spacing: 6) {

                Text("Coupon Code")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text(context.state.couponCode)
                    .font(.title2.monospaced())
                    .bold()
            }

            Divider()

            HStack {

                Label(
                    context.state.distance,
                    systemImage: "location.fill"
                )

                Spacer()

                Label {

                    Text(
                        context.state.expiryDate,
                        style: .relative
                    )

                } icon: {

                    Image(systemName: "clock")
                }
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .padding()
    }
}
