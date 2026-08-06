//
//  CouponReviewView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import SwiftUI
import SwiftData
import UIKit
import OSLog

private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier ?? "CouponFeature",
    category: "CouponReview"
)

struct CouponReviewView: View {

    @Environment(\.dismiss)
    private var dismiss

    @Environment(\.modelContext)
    private var modelContext

    @State
    private var viewModel = AddCouponViewModel()

    @State
    private var isSaving = false

    @State
    private var errorMessage: String?

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

                Button {

                    saveCoupon()

                } label: {

                    if isSaving {

                        ProgressView()

                    } else {

                        Text("Save")
                            .fontWeight(.semibold)
                    }
                }
                .disabled(isSaving)
            }
        }

        .alert(
            "Unable to Save",
            isPresented: Binding(
                get: {
                    errorMessage != nil
                },
                set: { value in

                    if !value {

                        errorMessage = nil
                    }
                }
            )
        ) {

            Button(
                "OK",
                role: .cancel
            ) { }

        } message: {

            Text(errorMessage ?? "")
        }

        .onAppear {

            populateForm()
        }
    }
}

// MARK: - Private Methods

private extension CouponReviewView {

    func populateForm() {

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

    func saveCoupon() {

        guard !isSaving else {
            return
        }

        Task {

            isSaving = true

            defer {

                isSaving = false
            }

            do {

                try viewModel.save(
                    mode: .create,
                    coupon: nil,
                    using: modelContext
                )

                logger.info("Coupon saved successfully")

                UINotificationFeedbackGenerator()
                    .notificationOccurred(.success)

                dismiss()

            } catch {

                logger.error("Failed to save coupon: \(error.localizedDescription)")

                UINotificationFeedbackGenerator()
                    .notificationOccurred(.error)

                errorMessage = "Couldn't save your coupon. Please try again."
            }
        }
    }
}

#Preview {

    NavigationStack {

        CouponReviewView(
            draft: CouponDraft(
                title: "Summer Sale",
                couponCode: "SAVE25",
                discountValue: 25,
                discountType: .percentage,
                expiryDate: .now.addingTimeInterval(86400 * 5),
                merchantName: "Starbucks",
                notes: "Detected using OCR"
            )
        )
    }
}
