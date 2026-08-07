//
//  AddCouponView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//


import SwiftUI
import SwiftData

struct AddCouponView: View {

    // MARK: - Environment

    @Environment(\.dismiss)
    private var dismiss

    @Environment(\.modelContext)
    private var modelContext

    // MARK: - State

    @State
    private var viewModel = AddCouponViewModel()

    @State
    private var isSaving = false

    @State
    private var errorMessage: String?

    // MARK: - Properties

    let mode: CouponFormMode

    let coupon: Coupon?

    // MARK: - Initializer

    init(
        mode: CouponFormMode = .create,
        coupon: Coupon? = nil
    ) {

        self.mode = mode
        self.coupon = coupon
    }

    // MARK: - Body

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

            // MARK: Cancel

            ToolbarItem(
                placement: .topBarLeading
            ) {

                Button("Cancel") {

                    dismiss()
                }
            }

            // MARK: Save

            ToolbarItem(
                placement: .topBarTrailing
            ) {

                Button {

                    saveCoupon()

                } label: {

                    if isSaving {

                        ProgressView()

                    } else {

                        Text(
                            mode == .create
                            ? "Save"
                            : "Update"
                        )
                        .fontWeight(.semibold)
                    }
                }
                .disabled(
                    !viewModel.canSave ||
                    isSaving
                )
            }
        }

        // MARK: Error Alert

        .alert(
            "Unable to Save",
            isPresented: Binding(
                get: {

                    errorMessage != nil

                },
                set: { newValue in

                    if !newValue {

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

            Text(
                errorMessage ?? "Something went wrong."
            )
        }

        // MARK: Load Coupon

        .task {

            guard
                mode == .edit,
                let coupon
            else {

                return
            }

            viewModel.load(
                from: coupon
            )
        }
    }
}

// MARK: - Private Methods

private extension AddCouponView {

    func saveCoupon() {

        Task {

            isSaving = true

            defer {

                isSaving = false
            }

            do {

                let savedCoupon = try viewModel.save(
                    mode: mode,
                    coupon: coupon,
                    using: modelContext
                )

                // Start Live Activity only when creating
                if mode == .create {

                    try await CouponActivityManager.shared.start(
                        for: savedCoupon
                    )
                }

                dismiss()

            } catch {

                errorMessage = error.localizedDescription
            }
        }
    }
}

#Preview {

    NavigationStack {

        AddCouponView()
    }
}
