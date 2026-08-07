//
//  CouponBackground.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//

//
//  CouponBackground.swift
//  OnePass
//

//
//  CouponBackground.swift
//  CouponFeature
//

import SwiftUI

struct CouponBackground: View {

    @Environment(\.colorScheme)
    private var colorScheme

    var body: some View {

        RoundedRectangle(
            cornerRadius: 28,
            style: .continuous
        )
        .fill(backgroundGradient)
        .overlay {

            RoundedRectangle(
                cornerRadius: 28,
                style: .continuous
            )
            .strokeBorder(
                borderColor,
                lineWidth: 1
            )
        }
        .shadow(
            color: shadowColor,
            radius: 14,
            y: 8
        )
    }
}

// MARK: - Private

private extension CouponBackground {

    var backgroundGradient: LinearGradient {

        if colorScheme == .dark {

            return LinearGradient(
                colors: [
                    Color(
                        red: 0.16,
                        green: 0.17,
                        blue: 0.20
                    ),
                    Color(
                        red: 0.10,
                        green: 0.11,
                        blue: 0.13
                    )
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

        } else {

            return LinearGradient(
                colors: [
                    Color(
                        red: 0.97,
                        green: 0.98,
                        blue: 1.00
                    ),
                    Color(
                        red: 0.93,
                        green: 0.96,
                        blue: 1.00
                    )
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }

    var borderColor: Color {

        colorScheme == .dark
            ? .white.opacity(0.08)
            : .black.opacity(0.06)
    }

    var shadowColor: Color {

        colorScheme == .dark
            ? .black.opacity(0.35)
            : .black.opacity(0.08)
    }
}

#Preview {

    CouponBackground()
        .frame(height: 250)
        .padding()
}
