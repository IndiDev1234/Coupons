//
//  CouponFeatureApp.swift
//  CouponFeature
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
                .onAppear {

                    container.start()
                }
        }
        .modelContainer(
            PersistenceController.shared.modelContainer
        )
    }
}
