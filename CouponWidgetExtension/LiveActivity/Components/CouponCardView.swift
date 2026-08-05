//
//  CouponCardView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 05/08/26.
//

import SwiftUI

struct CouponCardView<Content: View>: View {

    @ViewBuilder
    let content: Content

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: ActivitySpacing.medium
        ) {

            content

        }
        .padding(ActivitySpacing.medium)
        .background(
            RoundedRectangle(
                cornerRadius: ActivityRadius.card,
                style: .continuous
            )
            .fill(.regularMaterial)
        )
        .overlay(
            RoundedRectangle(
                cornerRadius: ActivityRadius.card,
                style: .continuous
            )
            .strokeBorder(.white.opacity(0.12))
        )
    }
}
