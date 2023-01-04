//
//  NumberFactTests.swift
//  NumberFactTests
//
//  Created by  Vladyslav Fil on 04.01.2023.
//

import XCTest
@testable import NumberFact
import ComposableArchitecture

@MainActor
class CounterTests: XCTestCase {
    func testBasics() async {
        let store = TestStore(
            initialState: Feature.State(),
            reducer: Feature()
        )
        
//        await store.send(.incrementButtonTapped) {
//            $0.count = 1
//        }
//        await store.send(.decrementButtonTapped) {
//            $0.count = 0
//        }
        
        store.dependencies.numberFact.fetch = { "\($0) is a good number Brent" }
        
        await store.send(.numberFactButtonTapped)
        await store.receive(.numberFactResponse(.success("0 is a good number Brent"))) {
            $0.numberFactAlert = "0 is a good number Brent"
        }
        
        await store.send(.factAlertDismissed) {
            $0.numberFactAlert = nil
        }
    }
}
