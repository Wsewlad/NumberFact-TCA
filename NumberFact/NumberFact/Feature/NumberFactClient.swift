//
//  NumberFactClient.swift
//  NumberFact
//
//  Created by  Vladyslav Fil on 04.01.2023.
//

import Foundation
import Dependencies

struct NumberFactClient {
  var fetch: (Int) async throws -> String
}

private enum NumberFactClientKey: DependencyKey {
    static let liveValue = NumberFactClient(
        fetch: { number in
            let (data, _) = try await URLSession.shared
                .data(from: .init(string: "http://numbersapi.com/\(number)")!)
            return String(decoding: data, as: UTF8.self)
        }
    )
}

extension DependencyValues {
    var numberFact: NumberFactClient {
        get { self[NumberFactClientKey.self] }
        set { self[NumberFactClientKey.self] = newValue }
    }
}
