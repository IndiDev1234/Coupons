//
//  CouponCardView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 05/08/26.
//

import SwiftUI

struct TicketShape: InsettableShape {
    var cornerRadius: CGFloat = 20
    var cutRadius: CGFloat = 8
    var cutHeightRatio: CGFloat = 0.33
    var insetAmount: CGFloat = 0

    func path(in rect: CGRect) -> Path {
        let insetRect = rect.insetBy(dx: insetAmount, dy: insetAmount)
        var path = Path()

        let w = insetRect.width
        let h = insetRect.height
        let x = insetRect.minX
        let y = insetRect.minY
        let cutY = y + h * cutHeightRatio
        let currentCornerRadius = max(0, cornerRadius - insetAmount)
        let currentCutRadius = max(0, cutRadius + insetAmount)

        // Start top-left
        path.move(to: CGPoint(x: x + currentCornerRadius, y: y))

        // Top edge
        path.addLine(to: CGPoint(x: x + w - currentCornerRadius, y: y))

        // Top-right corner
        path.addArc(center: CGPoint(x: x + w - currentCornerRadius, y: y + currentCornerRadius),
                    radius: currentCornerRadius,
                    startAngle: Angle(degrees: -90),
                    endAngle: Angle(degrees: 0),
                    clockwise: false)

        // Right edge down to cut
        path.addLine(to: CGPoint(x: x + w, y: cutY - currentCutRadius))

        // Right cut (semi-circle indenting leftwards)
        path.addArc(center: CGPoint(x: x + w, y: cutY),
                    radius: currentCutRadius,
                    startAngle: Angle(degrees: -90),
                    endAngle: Angle(degrees: 90),
                    clockwise: true)

        // Right edge down to bottom-right
        path.addLine(to: CGPoint(x: x + w, y: y + h - currentCornerRadius))

        // Bottom-right corner
        path.addArc(center: CGPoint(x: x + w - currentCornerRadius, y: y + h - currentCornerRadius),
                    radius: currentCornerRadius,
                    startAngle: Angle(degrees: 0),
                    endAngle: Angle(degrees: 90),
                    clockwise: false)

        // Bottom edge
        path.addLine(to: CGPoint(x: x + currentCornerRadius, y: y + h))

        // Bottom-left corner
        path.addArc(center: CGPoint(x: x + currentCornerRadius, y: y + h - currentCornerRadius),
                    radius: currentCornerRadius,
                    startAngle: Angle(degrees: 90),
                    endAngle: Angle(degrees: 180),
                    clockwise: false)

        // Left edge up to cut
        path.addLine(to: CGPoint(x: x, y: cutY + currentCutRadius))

        // Left cut (semi-circle indenting rightwards)
        path.addArc(center: CGPoint(x: x, y: cutY),
                    radius: currentCutRadius,
                    startAngle: Angle(degrees: 90),
                    endAngle: Angle(degrees: 270),
                    clockwise: true)

        // Left edge up to top-left
        path.addLine(to: CGPoint(x: x, y: y + currentCornerRadius))

        // Top-left corner
        path.addArc(center: CGPoint(x: x + currentCornerRadius, y: y + currentCornerRadius),
                    radius: currentCornerRadius,
                    startAngle: Angle(degrees: 180),
                    endAngle: Angle(degrees: 270),
                    clockwise: false)

        return path
    }

    func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.insetAmount += amount
        return shape
    }
}

struct DashedLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        return path
    }
}

struct CouponCardView<Header: View, Stub: View>: View {

    let status: CouponStatus
    @ViewBuilder let header: Header
    @ViewBuilder let stub: Stub

    private var statusColor: Color {
        switch status {
        case .active:
            return .indigo // Deep indigo glow for active status (dark themed glass)
        case .expiringSoon:
            return ActivityColors.warning
        case .expired:
            return ActivityColors.error
        case .redeemed:
            return .gray
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: ActivitySpacing.small) {
                header
            }
            .padding(.horizontal, ActivitySpacing.medium)
            .padding(.top, 14)
            .padding(.bottom, 10)

            // Dashed separator line with a glass shimming gradient
            DashedLine()
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [4, 4]))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.white.opacity(0.05), .white.opacity(0.3), .white.opacity(0.05)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(height: 1)
                .padding(.horizontal, 8)

            VStack(alignment: .leading, spacing: ActivitySpacing.small) {
                stub
            }
            .padding(.horizontal, ActivitySpacing.medium)
            .padding(.top, 10)
            .padding(.bottom, 14)
        }
        .background(
            ZStack {
                // 1. Ambient colorful glow behind the glass card (liquid glow)
                TicketShape(cornerRadius: ActivityRadius.card, cutRadius: 8, cutHeightRatio: 0.33)
                    .fill(
                        RadialGradient(
                            gradient: Gradient(colors: [statusColor.opacity(0.18), .clear]),
                            center: .topLeading,
                            startRadius: 5,
                            endRadius: 120
                        )
                    )
                    .blur(radius: 6)

                TicketShape(cornerRadius: ActivityRadius.card, cutRadius: 8, cutHeightRatio: 0.33)
                    .fill(
                        RadialGradient(
                            gradient: Gradient(colors: [statusColor.opacity(0.12), .clear]),
                            center: .bottomTrailing,
                            startRadius: 5,
                            endRadius: 100
                        )
                    )
                    .blur(radius: 6)

                // 2. Frosted glass thin material
                TicketShape(cornerRadius: ActivityRadius.card, cutRadius: 8, cutHeightRatio: 0.33)
                    .fill(.thinMaterial)
            }
        )
        .overlay(
            // 3. Specular highlight outline simulating light refraction on glass edges
            TicketShape(cornerRadius: ActivityRadius.card, cutRadius: 8, cutHeightRatio: 0.33)
                .strokeBorder(
                    LinearGradient(
                        colors: [
                            .white.opacity(0.35),
                            .white.opacity(0.05),
                            statusColor.opacity(0.2),
                            .white.opacity(0.05),
                            .black.opacity(0.2)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1.5
                )
        )
        .shadow(color: statusColor.opacity(0.08), radius: 8, x: 0, y: 4)
    }
}
