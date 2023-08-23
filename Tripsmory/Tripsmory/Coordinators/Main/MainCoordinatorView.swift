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
    let factory = viewModel.factory
    
    NavigationStack(path: $viewModel.destinations) {
      viewModel.rootView
        .navigationDestination(for: MainDestination.self) { destination in
          switch destination {
          case .tripDetail(let trip):
            factory.makeMainTripDetail(for: trip, onEdit: viewModel.onEdit)
          case .settings:
            factory.makeMainSettings(onSignoutSuccess: viewModel.onSignoutSuccess)
          }
        }
    }
    .fullScreenCover(item: $viewModel.editingDetail) { detail in
      factory.makeMainEditTrip(
        for: detail,
        onUpdated: viewModel.onTripUpdated,
        onDeleted: viewModel.onTripDeleted,
        onCancel: viewModel.onTripEditingCancel)
    }
  }
}
