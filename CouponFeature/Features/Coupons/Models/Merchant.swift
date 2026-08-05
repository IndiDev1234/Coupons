//
//  Merchant.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import Foundation
import SwiftData

@Model
final class Merchant {

    @Attribute(.unique)
    var id: UUID

    var name: String

    var category: MerchantCategory

    var website: URL?

    var supportEmail: String?

    var supportPhone: String?

    /// Store hex value or asset name
    var brandColor: String?

    var createdAt: Date

    var updatedAt: Date

    init(
        id: UUID = UUID(),
        name: String,
        category: MerchantCategory,
        website: URL? = nil,
        supportEmail: String? = nil,
        supportPhone: String? = nil,
        brandColor: String? = nil,
        createdAt: Date = .now,
        updatedAt: Date = .now
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.website = website
        self.supportEmail = supportEmail
        self.supportPhone = supportPhone
        self.brandColor = brandColor
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
