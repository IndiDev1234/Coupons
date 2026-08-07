//
//  CouponCodeView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//


import SwiftUI

struct CouponCodeView: View {

    let code: String

    var body: some View {

        VStack(alignment: .leading, spacing: 8) {

            Text("Coupon Code")
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(
                code.isEmpty
                ? "NO CODE"
                : code
            )
            .font(
                .system(
                    size: 24,
                    weight: .bold,
                    design: .monospaced
                )
            )
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background {

                RoundedRectangle(
                    cornerRadius: 14,
                    style: .continuous
                )
                .fill(.thinMaterial)
            }
            .overlay {

                RoundedRectangle(
                    cornerRadius: 14,
                    style: .continuous
                )
                .strokeBorder(
                    .quaternary,
                    style: StrokeStyle(
                        lineWidth: 1,
                        dash: [6]
                    )
                )
            }
        }
    }
}

#Preview {

    VStack(spacing: 30) {

        CouponCodeView(
            code: "SAVE20"
        )

        CouponCodeView(
            code: ""
        )
    }
    .padding()
}
