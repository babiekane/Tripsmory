//
//  MainCoordinatorViewModel.swift
//  Tripsmory
//
//  Created by yossa on 21/8/2566 BE.
//

import SwiftUI

final class MainCoordinatorViewModel: ObservableObject {
  
  init(factory: MainCoordinatorViewFactory, onSignoutSuccess: @escaping () -> Void) {
    self.factory = factory
    self.signoutCompletion = onSignoutSuccess
  }
  
  let factory: MainCoordinatorViewFactory
  let signoutCompletion: () -> Void
  
  @Published var destinations: [ViewItem] = []
  @Published var editItem: ViewItem?
  
  lazy var rootView: AnyView = {
    factory.makeMainRoot(onTripSelected: onTripSelected, onSettingsSelected: onSettingsSelected)
  }()
  
  func onTripSelected(_ item: TripListItem) {
    let view = factory.makeMainTripDetail(for: item, onEdit: onEdit)
    destinations.append(.init(view: view))
  }
  
  func onSettingsSelected() {
    let view = factory.makeMainSettings(onSignoutSuccess: onSignoutSuccess)
    destinations.append(.init(view: view))
  }
  
  func onEdit(_ detail: TripDetail) {
    let view = factory.makeMainEditTrip(
      for: detail,
      onUpdated: onTripUpdated,
      onDeleted: onTripDeleted,
      onCancel: onTripEditingCancel)
    editItem = .init(view: view)
  }
  
  func onTripUpdated() {
    editItem = nil
  }
  
  func onTripDeleted() {
    editItem = nil
    _ = destinations.popLast()
  }
  
  func onTripEditingCancel() {
    editItem = nil
  }
  
  func onSignoutSuccess() {
    signoutCompletion()
  }
}

struct ViewItem: Hashable, Identifiable {
  
  let id: UUID = UUID()
  let view: AnyView
  
  static func == (lhs: ViewItem, rhs: ViewItem) -> Bool {
    lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
