//
//  CouponReminder.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import Foundation
import SwiftData

@Model
final class CouponReminder {

    @Attribute(.unique)
    var id: UUID

    /// Type of reminder
    var type: ReminderType

    /// Used only when type == .custom
    var reminderDate: Date?

    /// Whether this reminder is enabled
    var isEnabled: Bool

    var createdAt: Date

    init(
        id: UUID = UUID(),
        type: ReminderType,
        reminderDate: Date? = nil,
        isEnabled: Bool = true,
        createdAt: Date = .now
    ) {
        self.id = id
        self.type = type
        self.reminderDate = reminderDate
        self.isEnabled = isEnabled
        self.createdAt = createdAt
    }
}
