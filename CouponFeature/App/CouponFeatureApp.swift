//
//  CouponFeatureApp.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 04/08/26.
//

import SwiftUI
import SwiftData

@main
struct CouponFeatureApp: App {

    var body: some Scene {

        WindowGroup {

            RootView()
        }
        .modelContainer(
            PersistenceController.shared.modelContainer
        )
    }
}
