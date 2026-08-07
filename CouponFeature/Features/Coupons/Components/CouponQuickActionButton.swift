//
//  CouponActionButton.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//


//
//  CouponActionButton.swift
//  CouponFeature
//

import SwiftUI

struct CouponQuickActionButton: View {

    let title: String

    let icon: String

    let tint: Color

    let action: () -> Void

    var body: some View {

        Button(action: action) {

            VStack(spacing: 12) {

                Image(systemName: icon)
                    .font(.title2)

                Text(title)
                    .font(.caption)
                    .multilineTextAlignment(.center)
            }
            .foregroundStyle(tint)
            .frame(maxWidth: .infinity)
            .frame(height: 90)
            .background(
                tint.opacity(0.12)
            )
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 18
                )
            )
        }
        .buttonStyle(.plain)
    }
}
