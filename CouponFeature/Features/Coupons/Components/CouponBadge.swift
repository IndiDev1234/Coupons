//
//  CouponBadge.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//

import SwiftUI

struct CouponBadge: View {

    enum Style {

        case intelligence
        case success
        case warning
        case error
        case neutral
    }

    let title: String
    let systemImage: String?
    let style: Style

    private var color: Color {

        switch style {

        case .intelligence:
            return .blue

        case .success:
            return .green

        case .warning:
            return .orange

        case .error:
            return .red

        case .neutral:
            return .gray
        }
    }

    var body: some View {

        HStack(spacing: 6) {

            if let systemImage {

                Image(systemName: systemImage)
            }

            Text(title)
                .font(.caption.weight(.semibold))
        }
        .foregroundStyle(color)
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(
            Capsule()
                .fill(color.opacity(0.15))
        )
    }
}

#Preview {

    VStack(spacing: 20) {

        CouponBadge(
            title: "Apple Intelligence",
            systemImage: "apple.intelligence",
            style: .intelligence
        )

        CouponBadge(
            title: "Featured",
            systemImage: "star.fill",
            style: .success
        )

        CouponBadge(
            title: "Expiring Soon",
            systemImage: "clock.fill",
            style: .warning
        )

        CouponBadge(
            title: "Expired",
            systemImage: "xmark.circle.fill",
            style: .error
        )
    }
    .padding()
}
