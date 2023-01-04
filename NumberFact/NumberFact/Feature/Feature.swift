//
//  Feature.swift
//  NumberFact
//
//  Created by  Vladyslav Fil on 26.12.2022.
//

import ComposableArchitecture
import Foundation

struct Feature: ReducerProtocol {
    @Dependency(\.numberFact) var numberFact
}

//MARK: - State
extension Feature {
    struct State: Equatable {
        var count = 0
        var numberFactAlert: String?
    }
}

//MARK: - Action
extension Feature {
    enum Action: Equatable {
        case factAlertDismissed
        case decrementButtonTapped
        case incrementButtonTapped
        case numberFactButtonTapped
        case numberFactResponse(TaskResult<String>)
    }
}

//MARK: - Reduce
extension Feature {
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .factAlertDismissed:
            state.numberFactAlert = nil
            return .none
            
        case .decrementButtonTapped:
            state.count -= 1
            return .none
            
        case .incrementButtonTapped:
            state.count += 1
            return .none
            
        case .numberFactButtonTapped:
            return .task { [count = state.count] in
                await .numberFactResponse(TaskResult { try await self.numberFact.fetch(count) })
            }
            
        case let .numberFactResponse(.success(fact)):
            state.numberFactAlert = fact
            return .none
            
        case .numberFactResponse(.failure):
            state.numberFactAlert = "Could not load a number fact :("
            return .none
        }
    }
}
