//
//  CouponDiscountBadgeView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 05/08/26.
//


import SwiftUI

struct CouponDiscountBadgeView: View {

    let discount: String

    var body: some View {

        Text(discount)
            .font(.headline.bold())
            .foregroundStyle(.white)
            .padding(.horizontal, ActivitySpacing.medium)
            .padding(.vertical, ActivitySpacing.xSmall)
            .background(
                Capsule(style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [
                                .green,
                                .mint
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
            )
    }
}
