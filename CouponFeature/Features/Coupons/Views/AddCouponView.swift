//
//  AddCouponView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//


import SwiftUI

struct AddCouponView: View {

    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = AddCouponViewModel()

    var body: some View {

        Form {

            Section("Coupon") {

                TextField(
                    "Coupon Title",
                    text: $viewModel.couponTitle
                )

                TextField(
                    "Coupon Code",
                    text: $viewModel.couponCode
                )
            }

            Section("Discount") {

                TextField(
                    "Discount",
                    text: $viewModel.discountValue
                )
                .keyboardType(.decimalPad)
            }

            Section("Expiry") {

                DatePicker(
                    "Expiry Date",
                    selection: $viewModel.expiryDate,
                    displayedComponents: .date
                )
            }
        }
        .navigationTitle("New Coupon")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {

            ToolbarItem(placement: .topBarLeading) {

                Button("Cancel") {

                    dismiss()
                }
            }

            ToolbarItem(placement: .topBarTrailing) {

                Button("Save") {

                }
                .disabled(
                    viewModel.couponTitle.isEmpty
                )
            }
        }
    }
}

#Preview {

    NavigationStack {

        AddCouponView()
    }
}
