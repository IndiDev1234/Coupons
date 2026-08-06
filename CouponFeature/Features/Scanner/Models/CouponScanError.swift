//
//  CouponScanError.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import Foundation

enum CouponScanError: LocalizedError {

    case imageNotFound
    case textRecognitionFailed
    case parsingFailed
    case unsupportedLanguage

    var errorDescription: String? {

        switch self {

        case .imageNotFound:
            return "Unable to load image."

        case .textRecognitionFailed:
            return "Unable to recognize text."

        case .parsingFailed:
            return "Unable to extract coupon information."

        case .unsupportedLanguage:
            return "Unsupported OCR language."
        }
    }
}
