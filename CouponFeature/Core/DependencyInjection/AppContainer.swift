//
//  AppContainer.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//
import Foundation
import Observation

import Foundation
import Observation

@Observable
@MainActor
final class AppContainer {

    static let shared = AppContainer()

    private init() { }
}
