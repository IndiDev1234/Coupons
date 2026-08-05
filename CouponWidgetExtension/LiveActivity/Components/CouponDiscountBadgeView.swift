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
            .font(.caption.bold())
            .foregroundStyle(.white)
            .lineLimit(1)
            .fixedSize(horizontal: true, vertical: false)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .fill(ActivityColors.successGradient)
            )
            .overlay(
                Capsule()
                    .strokeBorder(.white.opacity(0.15), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.12), radius: 2, x: 0, y: 1)
    }
}
