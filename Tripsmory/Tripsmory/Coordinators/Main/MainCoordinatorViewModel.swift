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
  
  @Published var destinations: [MainDestination] = []
  @Published var editingDetail: TripDetail?
  
  lazy var rootView: AnyView = {
    factory.makeMainRoot(onTripSelected: onTripSelected, onSettingsSelected: onSettingsSelected)
  }()
  
  func onTripSelected(_ item: TripListItem) {
    destinations.append(.tripDetail(item))
  }
  
  func onSettingsSelected() {
    destinations.append(.settings)
  }
  
  func onEdit(_ detail: TripDetail) {
    editingDetail = detail
  }
  
  func onTripUpdated() {
    // TODO
  }
  
  func onTripDeleted() {
    // TODO
  }
  
  func onTripEditingCancel() {
    // TODO
  }
  
  func onSignoutSuccess() {
    signoutCompletion()
  }
}

enum MainDestination: Hashable {
  case tripDetail(TripListItem)
  case settings
  
  static func == (lhs: MainDestination, rhs: MainDestination) -> Bool {
    switch (lhs, rhs) {
    case (.tripDetail(let leftValue), .tripDetail(let rightValue)):
      return leftValue == rightValue
      
    case (.settings, .settings):
      return true
      
    default:
      return false
    }
  }
  
  func hash(into hasher: inout Hasher) {
    switch self {
    case .tripDetail(let item):
      hasher.combine(item)
    default:
      break
    }
  }
}
