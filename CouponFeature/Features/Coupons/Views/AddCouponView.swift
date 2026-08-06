//
//  AddCouponView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//


import SwiftUI

struct AddCouponView: View {

    @Environment(\.dismiss)
    private var dismiss

    var body: some View {

        Form {

            Section("Coupon") {

                TextField("Coupon Title", text: .constant(""))

                TextField("Coupon Code", text: .constant(""))
            }

            Section("Discount") {

                TextField("Discount", text: .constant(""))
            }

            Section("Expiry") {

                DatePicker(
                    "Expiry Date",
                    selection: .constant(.now),
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
                .disabled(true)
            }
        }
    }
}

#Preview {

    NavigationStack {

        AddCouponView()
    }
}
