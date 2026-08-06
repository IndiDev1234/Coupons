//
//  AddCouponOptionsSheet.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//


import SwiftUI

struct AddCouponOptionsSheet: View {

    let addManually: () -> Void
    let scanCoupon: () -> Void

    var body: some View {

        NavigationStack {

            VStack(spacing: 24) {

                Capsule()
                    .fill(.tertiary)
                    .frame(width: 40, height: 5)
                    .padding(.top, 8)

                VStack(spacing: 8) {

                    Text("Add Coupon")
                        .font(.title2.bold())

                    Text("Choose how you'd like to add your coupon.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }

                VStack(spacing: 16) {

                    OptionCard(
                        icon: "viewfinder.circle.fill",
                        iconColor: .blue,
                        title: "Scan Coupon",
                        subtitle: "Scan using camera or photos",
                        action: scanCoupon
                    )

                    OptionCard(
                        icon: "square.and.pencil.circle.fill",
                        iconColor: .orange,
                        title: "Add Manually",
                        subtitle: "Enter coupon details yourself",
                        action: addManually
                    )
                }

                Spacer(minLength: 10)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Option Card

private struct OptionCard: View {

    let icon: String
    let iconColor: Color
    let title: String
    let subtitle: String
    let action: () -> Void

    var body: some View {

        Button(action: action) {

            HStack(spacing: 16) {

                Image(systemName: icon)
                    .font(.system(size: 34))
                    .foregroundStyle(iconColor)
                    .frame(width: 52)

                VStack(alignment: .leading, spacing: 4) {

                    Text(title)
                        .font(.headline)

                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundStyle(.tertiary)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(.secondarySystemGroupedBackground))
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 20,
                    style: .continuous
                )
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {

    AddCouponOptionsSheet {

    } scanCoupon: {

    }
}
