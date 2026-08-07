//
//  CouponCodeCard.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//


//
//  CouponCodeCard.swift
//  CouponFeature
//

import SwiftUI
import UIKit

struct CouponCodeCard: View {

    let coupon: Coupon

    @State
    private var copied = false

    var body: some View {

        VStack(alignment: .leading, spacing: 20) {

            HStack {

                Text("Coupon Code")
                    .font(.headline)

                Spacer()

                Button {

                    copyCode()

                } label: {

                    Label(
                        copied ? "Copied" : "Copy",
                        systemImage: copied
                        ? "checkmark.circle.fill"
                        : "doc.on.doc"
                    )
                }
            }

            if let code = coupon.couponCode,
               !code.isEmpty {

                Text(code)
                    .font(
                        .system(
                            size: 24,
                            weight: .bold,
                            design: .monospaced
                        )
                    )
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )

            } else {

                ContentUnavailableView(
                    "No Coupon Code",
                    systemImage: "barcode.viewfinder"
                )
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(.regularMaterial)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 24
            )
        )
    }
}

// MARK: - Private

private extension CouponCodeCard {

    func copyCode() {

        guard let code = coupon.couponCode else {

            return
        }

        UIPasteboard.general.string = code

        UINotificationFeedbackGenerator()
            .notificationOccurred(.success)

        withAnimation {

            copied = true
        }

        DispatchQueue.main.asyncAfter(
            deadline: .now() + 2
        ) {

            withAnimation {

                copied = false
            }
        }
    }
}