//
//  CompositionRoot+RootViewFactory.swift
//  Tripsmory
//
//  Created by yossa on 22/8/2566 BE.
//

import SwiftUI

extension CompositionRoot: RootViewFactory {
  func makeRootStartFlow(onAuthSuccess: @escaping () -> Void) -> AnyView {
    let viewModel = StartCoordinatorViewModel(factory: self, onAuthSuccess: onAuthSuccess)
    let view = StartCoordinatorView(viewModel: viewModel)
    return AnyView(view)
  }
  
  func makeRootMainFlow(onSignoutSuccess: @escaping () -> Void) -> AnyView {
    let viewModel = MainCoordinatorViewModel(factory: self, onSignoutSuccess: onSignoutSuccess)
    let view = MainCoordinatorView(viewModel: viewModel)
    return AnyView(view)
  }
}
