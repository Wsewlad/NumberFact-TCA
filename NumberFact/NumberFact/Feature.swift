//
//  Feature.swift
//  NumberFact
//
//  Created by  Vladyslav Fil on 26.12.2022.
//

import ComposableArchitecture

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
}
