//
//  AddCouponViewModel.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import Foundation
import Observation
import SwiftData

@Observable
final class AddCouponViewModel {

    // MARK: Merchant

    var merchantName = ""

    var storeName = ""

    var merchantCategory: MerchantCategory = .other

    // MARK: Coupon

    var couponTitle = ""

    var couponCode = ""

    // MARK: Discount

    var discountValue = ""

    var discountType: DiscountType = .percentage

    var minimumPurchase = ""

    // MARK: Expiry

    var expiryDate = Date()

    // MARK: Notes

    var notes = ""
    
    @MainActor
    func saveCoupon(
        using modelContext: ModelContext
    ) throws {

        // MARK: Find Existing Merchant

        let merchantDescriptor = FetchDescriptor<Merchant>(
            predicate: #Predicate {
                $0.name == merchantName
            }
        )

        let merchant: Merchant

        if let existingMerchant = try modelContext.fetch(merchantDescriptor).first {

            merchant = existingMerchant

        } else {

            merchant = Merchant(
                name: merchantName,
                category: merchantCategory
            )

            modelContext.insert(merchant)
        }

        // MARK: Create Coupon

        let coupon = Coupon(
            title: couponTitle,
            couponCode: couponCode.isEmpty ? nil : couponCode,
            discountValue: Double(discountValue),
            discountType: discountType,
            minimumPurchase: Double(minimumPurchase),
            expiryDate: expiryDate,
            termsAndConditions: nil,
            notes: notes.isEmpty ? nil : notes
        )

        // MARK: Relationship

        coupon.merchant = merchant

        // MARK: Save

        modelContext.insert(coupon)

        try modelContext.save()
    }
}


