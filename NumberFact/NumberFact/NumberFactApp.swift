//
//  NumberFactApp.swift
//  NumberFact
//
//  Created by  Vladyslav Fil on 26.12.2022.
//

import SwiftUI
import ComposableArchitecture

@main
struct NumberFactApp: App {
    var body: some Scene {
        WindowGroup {
            FeatureView(
                store: Store(
                    initialState: Feature.State(),
                    reducer: Feature()
                )
            )
        }
    }
}
