//
//  AddCouponView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

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
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        @Bindable var viewModel = viewModel
        Form {

            // MARK: Merchant

            Section("Merchant") {

                TextField(
                    "Merchant Name",
                    text: $viewModel.merchantName
                )
                .textInputAutocapitalization(.words)

                TextField(
                    "Store (Optional)",
                    text: $viewModel.storeName
                )
                .textInputAutocapitalization(.words)

                Picker(
                    "Category",
                    selection: $viewModel.merchantCategory
                ) {

                    ForEach(
                        MerchantCategory.allCases,
                        id: \.self
                    ) { category in

                        Text(category.displayName)
                            .tag(category)
                    }
                }
            }

            // MARK: Coupon Information

            Section("Coupon Information") {

                TextField(
                    "Coupon Title",
                    text: $viewModel.couponTitle
                )

                TextField(
                    "Coupon Code",
                    text: $viewModel.couponCode
                )

                TextField(
                    "Minimum Purchase",
                    text: $viewModel.minimumPurchase
                )
                .keyboardType(.decimalPad)
            }

            // MARK: Discount

            Section("Discount") {

                Picker(
                    "Discount Type",
                    selection: $viewModel.discountType
                ) {

                    Text("Percentage")
                        .tag(DiscountType.percentage)

                    Text("Fixed Amount")
                        .tag(DiscountType.fixedAmount)

                    Text("Free Item")
                        .tag(DiscountType.freeItem)
                }

                TextField(
                    "Discount Value",
                    text: $viewModel.discountValue
                )
                .keyboardType(.decimalPad)
            }

            // MARK: Expiry

            Section("Expiry") {

                DatePicker(
                    "Expiry Date",
                    selection: $viewModel.expiryDate,
                    displayedComponents: .date
                )
            }

            // MARK: Notes

            Section("Notes") {

                TextField(
                    "Notes (Optional)",
                    text: $viewModel.notes,
                    axis: .vertical
                )
                .lineLimit(3...6)
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

                    do {

                        try viewModel.saveCoupon(
                            using: modelContext
                        )

                        dismiss()

                    } catch {

                        print("Failed to save coupon:", error)
                    }
                }
                .disabled(
                    viewModel.merchantName
                        .trimmingCharacters(in: .whitespacesAndNewlines)
                        .isEmpty ||

                    viewModel.couponTitle
                        .trimmingCharacters(in: .whitespacesAndNewlines)
                        .isEmpty
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
