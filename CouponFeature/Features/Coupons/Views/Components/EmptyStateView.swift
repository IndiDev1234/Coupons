//
//  EmptyStateView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//
//
//  EmptyStateView.swift
//  CouponFeature
//

import SwiftUI

struct EmptyStateView: View {
    let onAddCoupon: () -> Void
    
    var body: some View {

        VStack {

            Spacer()

            VStack(spacing: 32) {

                Image(systemName: "ticket.fill")
                    .font(.system(size: 72))
                    .foregroundStyle(.orange)

                VStack(spacing: 12) {

                    Text("No Coupons Yet")
                        .font(.title2.bold())

                    Text("""
                         Save coupons from stores,
                         emails or photos.
                         They'll appear here automatically.
                         """)
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 280)
                }

                Button {

                    // TODO: Navigate to Add Coupon
                    onAddCoupon()

                } label: {

                    Label("Add Coupon", systemImage: "plus.circle.fill")
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 24)
    }
}

