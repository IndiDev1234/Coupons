//
//  AIError.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import Foundation

enum AIError: LocalizedError {

    case modelUnavailable
    case emptyOCR
    case invalidResponse
    case decodingFailed
    case validationFailed
    case unsupportedContent
    case unknown

    var errorDescription: String? {

        switch self {

        case .modelUnavailable:
            return "Apple Intelligence is currently unavailable."

        case .emptyOCR:
            return "No text was detected in the scanned coupon."

        case .invalidResponse:
            return "The AI returned an invalid response."

        case .decodingFailed:
            return "Failed to decode the AI response."

        case .validationFailed:
            return "The extracted coupon information could not be validated."

        case .unsupportedContent:
            return "The scanned document does not appear to be a coupon."

        case .unknown:
            return "Something went wrong while analyzing the coupon."
        }
    }
}
