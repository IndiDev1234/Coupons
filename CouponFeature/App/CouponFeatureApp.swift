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

    @State private var container = AppContainer.shared

    var body: some Scene {

        WindowGroup {

            RootView()
                .environment(container)
        }
        .modelContainer(
            PersistenceController.shared.modelContainer
        )
    }
}
