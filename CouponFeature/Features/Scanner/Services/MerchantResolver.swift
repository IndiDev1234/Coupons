//
// MerchantResolver.swift
//

import Foundation

protocol MerchantResolverProtocol {

    func resolve(
        from text: String
    ) -> MerchantMatch?
}
