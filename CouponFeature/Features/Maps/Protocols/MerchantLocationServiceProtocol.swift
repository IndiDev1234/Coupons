//
//  MerchantLocationServiceProtocol.swift
//

import Foundation

protocol MerchantLocationServiceProtocol {

    func searchNearbyStores(
        merchantName: String
    ) async throws -> [MerchantLocation]
}
