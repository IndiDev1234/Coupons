//
//  FoundationModelServiceProtocol.swift
//  CouponFeature
//

import Foundation

protocol FoundationModelServiceProtocol {

    func extractCoupon(
        from scanResult: CouponScanResult
    ) async throws -> CouponExtraction
}
