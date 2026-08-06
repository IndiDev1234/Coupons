//
//  AddCouponView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import SwiftUI
import SwiftData

struct AddCouponView: View {

    @Environment(\.dismiss)
    private var dismiss

    @Environment(\.modelContext)
    private var modelContext

    @State
    private var viewModel = AddCouponViewModel()

    let mode: CouponFormMode
    let coupon: Coupon?

    init(
        mode: CouponFormMode = .create,
        coupon: Coupon? = nil
    ) {
        self.mode = mode
        self.coupon = coupon
    }

    var body: some View {

        @Bindable var viewModel = viewModel

        CouponFormView(
            viewModel: viewModel
        )
        .navigationTitle(
            mode == .create
            ? "New Coupon"
            : "Edit Coupon"
        )
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {

            ToolbarItem(placement: .topBarLeading) {

                Button("Cancel") {
                    dismiss()
                }
            }

            ToolbarItem(placement: .topBarTrailing) {

                Button(
                    mode == .create
                    ? "Save"
                    : "Update"
                ) {

                    do {

                        try viewModel.save(
                            mode: mode,
                            coupon: coupon,
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
        .onAppear {

            guard
                mode == .edit,
                let coupon
            else {
                return
            }

            viewModel.load(from: coupon)
        }
    }
}

#Preview {

    NavigationStack {

        AddCouponView()
    }
}
