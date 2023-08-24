//
//  MainCoordinatorView.swift
//  Tripsmory
//
//  Created by CatMeox on 8/5/2566 BE.
//

import SwiftUI

struct MainCoordinatorView: View {
  
  @ObservedObject var viewModel: MainCoordinatorViewModel
  
  var body: some View {
    NavigationStack(path: $viewModel.destinations) {
      viewModel.rootView
        .navigationDestination(for: ViewItem.self) { item in
          item.view
        }
    }
    .fullScreenCover(item: $viewModel.editItem) { item in
      item.view
    }
  }
}
