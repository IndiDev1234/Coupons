//
//  PersistenceController.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 04/08/26.
//


import SwiftData

@MainActor
final class PersistenceController {

    static let shared = PersistenceController()

    let modelContainer: ModelContainer

    private init() {

        do {

            modelContainer = try ModelContainerFactory.makeModelContainer()

        } catch {

            fatalError(
                "Unable to create ModelContainer: \(error)"
            )
        }
    }
}
