//
//  SwiftUIView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import Foundation
import SwiftData

@Model
final class CouponUsage {

    @Attribute(.unique)
    var id: UUID

    /// Date when the coupon was used
    var redeemedAt: Date

    /// Status of this usage record
    var status: CouponUsageStatus

    /// Amount saved (optional)
    var savingsAmount: Double?

    /// User notes
    var notes: String?

    var createdAt: Date

    init(
        id: UUID = UUID(),
        redeemedAt: Date = .now,
        status: CouponUsageStatus = .redeemed,
        savingsAmount: Double? = nil,
        notes: String? = nil,
        createdAt: Date = .now
    ) {

        self.id = id
        self.redeemedAt = redeemedAt
        self.status = status
        self.savingsAmount = savingsAmount
        self.notes = notes
        self.createdAt = createdAt
    }
}
