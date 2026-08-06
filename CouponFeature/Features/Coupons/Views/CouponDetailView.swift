//
//  CouponDetailView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//
//
//  CouponDetailView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import SwiftUI
import SwiftData

struct CouponDetailView: View {

    let coupon: Coupon

    @Environment(\.modelContext)
    private var modelContext

    @Environment(\.dismiss)
    private var dismiss

    @State
    private var showDeleteConfirmation = false

    @State
    private var showEditSheet = false

    var body: some View {

        ScrollView {

            VStack(spacing: 24) {

                CouponListCardView(
                    coupon: coupon
                )

                couponInformation

                if let notes = coupon.notes,
                   !notes.isEmpty {

                    notesSection(notes)
                }

                Spacer(minLength: 40)
            }
            .padding()
        }
        .navigationTitle("Coupon")
        .navigationBarTitleDisplayMode(.inline)

        .toolbar {

            ToolbarItemGroup(placement: .topBarTrailing) {

                Button {

                    showEditSheet = true

                } label: {

                    Image(systemName: "square.and.pencil")
                }

                Button {

                    showDeleteConfirmation = true

                } label: {

                    Image(systemName: "trash")
                        .foregroundStyle(.red)
                }
            }
        }

        .sheet(isPresented: $showEditSheet) {

            NavigationStack {

                AddCouponView(
                    mode: .edit,
                    coupon: coupon
                )
            }
        }

        .confirmationDialog(
            "Delete Coupon?",
            isPresented: $showDeleteConfirmation,
            titleVisibility: .visible
        ) {

            Button(
                "Delete",
                role: .destructive
            ) {

                deleteCoupon()
            }

            Button(
                "Cancel",
                role: .cancel
            ) { }

        } message: {

            Text("This action cannot be undone.")
        }
    }

    // MARK: Delete

    private func deleteCoupon() {

        modelContext.delete(coupon)

        do {

            try modelContext.save()

            dismiss()

        } catch {

            print("Failed to delete coupon:", error)
        }
    }
}

// MARK: Coupon Information

private extension CouponDetailView {

    var couponInformation: some View {

        VStack(alignment: .leading, spacing: 18) {

            Label(
                "Merchant",
                systemImage: "building.2"
            )

            Text(coupon.merchant?.name ?? "Unknown Merchant")

            Divider()

            Label(
                "Coupon Code",
                systemImage: "ticket"
            )

            Text(coupon.couponCode ?? "No Code")
                .font(.title2.monospaced().bold())

            Divider()

            Label(
                "Discount",
                systemImage: "tag"
            )

            Text(discountText)

            Divider()

            Label(
                "Expiry",
                systemImage: "calendar"
            )

            if let expiry = coupon.expiryDate {

                Text(
                    expiry.formatted(
                        date: .abbreviated,
                        time: .omitted
                    )
                )

            } else {

                Text("No Expiry")
            }

            Divider()

            Label(
                "Minimum Purchase",
                systemImage: "cart"
            )

            if let minimum = coupon.minimumPurchase {

                Text("₹\(minimum.formatted())")

            } else {

                Text("None")
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.background)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 20
            )
        )
    }

    func notesSection(
        _ notes: String
    ) -> some View {

        VStack(alignment: .leading, spacing: 12) {

            Text("Notes")
                .font(.headline)

            Text(notes)
        }
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
        .padding()
        .background(.background)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 20
            )
        )
    }

    var discountText: String {

        guard let value = coupon.discountValue else {

            return "Offer"
        }

        switch coupon.discountType {

        case .percentage:

            return "\(Int(value))% OFF"

        case .fixedAmount:

            return "₹\(Int(value)) OFF"

        case .freeItem:

            return "Free Item"
        }
    }
}

#Preview {

    NavigationStack {

        CouponDetailView(
            coupon: Coupon(
                title: "Summer Special",
                couponCode: "STAR25",
                discountValue: 25,
                discountType: .percentage,
                expiryDate: .now.addingTimeInterval(86400 * 5)
            )
        )
    }
}
