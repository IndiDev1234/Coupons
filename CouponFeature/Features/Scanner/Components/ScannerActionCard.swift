//
//  ScannerActionCard.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//


import SwiftUI

struct ScannerActionCard: View {

    let icon: String
    let iconColor: Color
    let title: String
    let subtitle: String
    let action: () -> Void

    @State
    private var isPressed = false

    var body: some View {

        Button {

            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()

            action()

        } label: {

            HStack(spacing: 18) {

                ZStack {

                    Circle()
                        .fill(iconColor.opacity(0.15))
                        .frame(width: 58, height: 58)

                    Image(systemName: icon)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(iconColor)
                }

                VStack(alignment: .leading, spacing: 6) {

                    Text(title)
                        .font(.headline)

                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.leading)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.headline)
                    .foregroundStyle(.tertiary)
            }
            .padding(20)
            .frame(maxWidth: .infinity)
            .background {

                RoundedRectangle(cornerRadius: 26)
                    .fill(.background)
            }
            .overlay {

                RoundedRectangle(cornerRadius: 26)
                    .strokeBorder(.quaternary)
            }
            .scaleEffect(isPressed ? 0.98 : 1)
            .animation(
                .spring(
                    response: 0.30,
                    dampingFraction: 0.75
                ),
                value: isPressed
            )
        }
        .buttonStyle(.plain)
        .simultaneousGesture(

            DragGesture(minimumDistance: 0)

                .onChanged { _ in

                    isPressed = true
                }

                .onEnded { _ in

                    isPressed = false
                }
        )
    }
}

#Preview {

    VStack(spacing: 20) {

        ScannerActionCard(
            icon: "viewfinder.circle.fill",
            iconColor: .blue,
            title: "Scan with Camera",
            subtitle: "Use the camera to scan a printed coupon."
        ) {

        }

        ScannerActionCard(
            icon: "photo.on.rectangle.angled",
            iconColor: .green,
            title: "Choose from Photos",
            subtitle: "Import a screenshot or saved coupon."
        ) {

        }
    }
    .padding()
}
