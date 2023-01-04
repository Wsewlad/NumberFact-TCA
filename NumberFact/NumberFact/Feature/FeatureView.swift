//
//  FeatureView.swift
//  NumberFact
//
//  Created by  Vladyslav Fil on 27.12.2022.
//

import SwiftUI
import ComposableArchitecture

struct FeatureView: View {
    let store: StoreOf<Feature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                HStack {
                    Button("-") { viewStore.send(.decrementButtonTapped) }
                    Text("\(viewStore.count)")
                    Button("+") { viewStore.send(.incrementButtonTapped) }
                }
                
                Button("Number fact") { viewStore.send(.numberFactButtonTapped) }
            }
            .alert(
                item: viewStore.binding(
                    get: { $0.numberFactAlert.map(FactAlert.init(title:)) },
                    send: .factAlertDismissed),
                content: { Alert(title: Text($0.title)) }
            )
        }
    }
}

struct FactAlert: Identifiable {
  var title: String
  var id: String { self.title }
}
