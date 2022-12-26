//
//  Feature.swift
//  NumberFact
//
//  Created by  Vladyslav Fil on 26.12.2022.
//

import ComposableArchitecture
import Foundation

struct Feature: ReducerProtocol {
    struct State: Equatable {
        var count = 0
        var numberFactAlert: String?
    }
    
    enum Action: Equatable {
        case factAlertDismissed
        case decrementButtonTapped
        case incrementButtonTapped
        case numberFactButtonTapped
        case numberFactResponse(TaskResult<String>)
    }
    
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
                await .numberFactResponse(
                    TaskResult {
                        String(
                            decoding: try await URLSession.shared.data(from: URL(string: "http://numbersapi.com/\(count)/trivia")!).0,
                            as: UTF8.self
                        )
                    }
                )
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
