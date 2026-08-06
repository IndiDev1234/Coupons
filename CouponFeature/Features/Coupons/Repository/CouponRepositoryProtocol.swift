//
//  CouponRepositoryProtocol.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import Foundation

@MainActor
protocol CouponRepositoryProtocol {

    func fetchAll() throws -> [Coupon]

    func fetch(by id: UUID) throws -> Coupon?

    func insert(_ coupon: Coupon) throws

    func update() throws

    func delete(_ coupon: Coupon) throws
}
