//
//  FoundationModelServiceProtocol.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//


import Foundation

protocol FoundationModelServiceProtocol {

    /// Sends OCR output to Apple's Foundation Model
    /// and returns structured coupon information.
    func analyze(
        scanResult: CouponScanResult
    ) async throws -> AICouponResult
}
