//
//  CouponReviewView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import SwiftUI

struct CouponReviewView: View {

    @Environment(\.dismiss)
    private var dismiss

    @Environment(\.modelContext)
    private var modelContext

    @State
    private var viewModel = AddCouponViewModel()

    let draft: CouponDraft

    var body: some View {

        @Bindable var viewModel = viewModel

        CouponFormView(
            viewModel: viewModel
        )
        .navigationTitle("Review Coupon")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {

            ToolbarItem(placement: .topBarTrailing) {

                Button("Save") {

                    do {

                        try viewModel.save(
                            mode: .create,
                            coupon: nil,
                            using: modelContext
                        )

                        dismiss()

                    } catch {

                        print(error)
                    }
                }
            }
        }
        .onAppear {

            populateForm()
        }
    }

    private func populateForm() {

        viewModel.merchantName = draft.merchantName
        viewModel.storeName = draft.storeName

        viewModel.couponTitle = draft.title
        viewModel.couponCode = draft.couponCode

        viewModel.discountType = draft.discountType

        if let value = draft.discountValue {

            viewModel.discountValue = String(value)
        }

        if let minimum = draft.minimumPurchase {

            viewModel.minimumPurchase = String(minimum)
        }

        if let expiry = draft.expiryDate {

            viewModel.expiryDate = expiry
        }

        viewModel.notes = draft.notes
    }
}
