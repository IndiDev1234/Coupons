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

    // MARK: Load Existing Coupon

    func load(from coupon: Coupon) {

        merchantName = coupon.merchant?.name ?? ""
        merchantCategory = coupon.merchant?.category ?? .other

        couponTitle = coupon.title
        couponCode = coupon.couponCode ?? ""

        discountValue = coupon.discountValue.map {
            String($0)
        } ?? ""

        discountType = coupon.discountType

        minimumPurchase = coupon.minimumPurchase.map {
            String($0)
        } ?? ""

        expiryDate = coupon.expiryDate ?? .now
        notes = coupon.notes ?? ""
    }

    // MARK: Save

    @MainActor
    func save(
        mode: CouponFormMode,
        coupon: Coupon?,
        using modelContext: ModelContext
    ) throws {

        // Find existing merchant

        let descriptor = FetchDescriptor<Merchant>(
            predicate: #Predicate {
                $0.name == merchantName
            }
        )

        let merchant: Merchant

        if let existing = try modelContext.fetch(descriptor).first {

            merchant = existing

            // Keep category updated if it changed
            merchant.category = merchantCategory

        } else {

            merchant = Merchant(
                name: merchantName,
                category: merchantCategory
            )

            modelContext.insert(merchant)
        }

        switch mode {

        case .create:

            let newCoupon = Coupon(
                title: couponTitle,
                couponCode: couponCode.isEmpty ? nil : couponCode,
                discountValue: Double(discountValue),
                discountType: discountType,
                minimumPurchase: Double(minimumPurchase),
                expiryDate: expiryDate,
                termsAndConditions: nil,
                notes: notes.isEmpty ? nil : notes
            )

            newCoupon.merchant = merchant

            modelContext.insert(newCoupon)

        case .edit:

            guard let coupon else {
                return
            }

            coupon.title = couponTitle
            coupon.couponCode = couponCode.isEmpty ? nil : couponCode
            coupon.discountValue = Double(discountValue)
            coupon.discountType = discountType
            coupon.minimumPurchase = Double(minimumPurchase)
            coupon.expiryDate = expiryDate
            coupon.notes = notes.isEmpty ? nil : notes
            coupon.updatedAt = .now
            coupon.merchant = merchant
        }

        try modelContext.save()
    }
}
