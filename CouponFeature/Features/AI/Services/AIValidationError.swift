//
//  AIValidationError.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//


import Foundation

enum AIValidationError: LocalizedError {

    case merchantMissing
    case invalidDiscount
    case invalidMinimumPurchase
    case invalidExpiry
    case confidenceTooLow

    var errorDescription: String? {

        switch self {

        case .merchantMissing:
            return "Merchant could not be identified."

        case .invalidDiscount:
            return "Invalid discount value."

        case .invalidMinimumPurchase:
            return "Invalid minimum purchase."

        case .invalidExpiry:
            return "Invalid expiry date."

        case .confidenceTooLow:
            return "AI confidence is too low."
        }
    }
}