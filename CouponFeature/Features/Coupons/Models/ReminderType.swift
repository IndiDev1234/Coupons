//
//  ReminderType.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import Foundation

enum ReminderType: String, Codable, CaseIterable {

    case onExpiry
    case oneHourBefore
    case oneDayBefore
    case oneWeekBefore
    case custom
}
