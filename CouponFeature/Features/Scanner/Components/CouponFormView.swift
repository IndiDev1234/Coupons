//
//  CouponFormView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import SwiftUI

struct CouponFormView: View {

    @Bindable var viewModel: AddCouponViewModel

    var body: some View {

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
                    "Notes",
                    text: $viewModel.notes,
                    axis: .vertical
                )
                .lineLimit(3...6)
            }
        }
    }
}
