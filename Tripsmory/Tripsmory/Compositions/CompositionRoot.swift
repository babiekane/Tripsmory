//
//  CompositionRoot.swift
//  Tripsmory
//
//  Created by yossa on 21/8/2566 BE.
//

import SwiftUI

final class CompositionRoot {
  func makeRootView() -> AnyView {
    let viewModel = RootViewModel(factory: self)
    let view = RootView(viewModel: viewModel)
    return AnyView(view)
  }
}
