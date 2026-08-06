//
//  Store.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import Foundation
import SwiftData

@Model
final class Store {

    @Attribute(.unique)
    var id: UUID

    var name: String

    var address: String

    var city: String

    var state: String

    var postalCode: String?

    var country: String

    var latitude: Double?

    var longitude: Double?

    var createdAt: Date

    var updatedAt: Date

    init(
        id: UUID = UUID(),
        name: String,
        address: String,
        city: String,
        state: String,
        postalCode: String? = nil,
        country: String,
        latitude: Double? = nil,
        longitude: Double? = nil,
        createdAt: Date = .now,
        updatedAt: Date = .now
    ) {

        self.id = id
        self.name = name
        self.address = address
        self.city = city
        self.state = state
        self.postalCode = postalCode
        self.country = country
        self.latitude = latitude
        self.longitude = longitude
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
