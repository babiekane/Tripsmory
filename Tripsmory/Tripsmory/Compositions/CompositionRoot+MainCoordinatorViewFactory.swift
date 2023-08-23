//
//  CompositionRoot+MainCoordinatorViewFactory.swift
//  Tripsmory
//
//  Created by yossa on 21/8/2566 BE.
//

import SwiftUI

extension CompositionRoot: MainCoordinatorViewFactory {
  func makeMainRoot(onTripSelected: @escaping (TripListItem) -> Void, onSettingsSelected: @escaping () -> Void) -> AnyView {
    let viewModel = TripListViewModel(onTripSelected: onTripSelected, onSettingsSelected: onSettingsSelected)
    let view = TripListView(viewModel: viewModel)
    return AnyView(view)
  }
  
  func makeMainTripDetail(for item: TripListItem, onEdit: @escaping (TripDetail) -> Void) -> AnyView {
    let viewModel = TripDetailViewModel(tripID: item.id)
    let view = TripDetailView(viewModel: viewModel)
    return AnyView(view)
  }
  
  func makeMainEditTrip(for detail: TripDetail, onUpdated: @escaping () -> Void, onDeleted: @escaping () -> Void, onCancel: @escaping () -> Void) -> AnyView {
    let viewModel = EditTripViewModel(detail: detail, onUpdated: onUpdated, onDeleted: onDeleted, onCancel: onCancel)
    let view = EditTripView(viewModel: viewModel)
    return AnyView(view)
  }
  
  func makeMainSettings(onSignoutSuccess: @escaping () -> Void) -> AnyView {
    let viewModel = SettingsViewModel(onSignoutSuccess: onSignoutSuccess)
    let view = SettingsView(viewModel: viewModel)
    return AnyView(view)
  }
}
