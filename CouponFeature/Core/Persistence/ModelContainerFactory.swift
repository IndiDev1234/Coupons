//
//  ModelContainerFactory.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//


import SwiftData

enum ModelContainerFactory {

    static func makeModelContainer() throws -> ModelContainer {

        let configuration = ModelConfiguration(
            schema: AppSchema.schema,
            isStoredInMemoryOnly: false
        )

        return try ModelContainer(
            for: AppSchema.schema,
            configurations: configuration
        )
    }
}
