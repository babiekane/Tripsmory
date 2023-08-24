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
  
  lazy var tripDetailUpdater = TripDetailUpdater()
  
  func onTripSelected(_ item: TripListItem) {
    let (view, updatable) = factory.makeMainTripDetail(for: item, onEdit: onEdit)
    tripDetailUpdater.updatable = updatable
    destinations.append(.init(view: view))
  }
  
  func onSettingsSelected() {
    let view = factory.makeMainSettings(
      onResetPasswordSelected: onResetPasswordSelected,
      onManageAccountSelected: onManageAccountSelected,
      onPrivacyPolicySelected: onPrivacyPolicySelected,
      onSupportAndFeedbackSelected: onSupportAndFeedbackSelected,
      onSignoutSuccess: onSignoutSuccess)
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
    tripDetailUpdater.beginUpdate()
  }
  
  func onTripDeleted() {
    editItem = nil
    pop()
  }
  
  func onTripEditingCancel() {
    editItem = nil
  }
  
  func onResetPasswordSelected() {
    let view = factory.makeMainResetPassword(onResetPasswordSuccess: pop)
    destinations.append(.init(view: view))
  }
  
  func onManageAccountSelected() {
    let view = factory.makeMainManageAccount(onUserDeleted: onSignoutSuccess)
    destinations.append(.init(view: view))
  }
  
  func onPrivacyPolicySelected() {
    let view = factory.makeMainPrivacyPolicy()
    destinations.append(.init(view: view))
  }
  
  func onSupportAndFeedbackSelected() {
    let view = factory.makeMainSupportAndFeedback()
    destinations.append(.init(view: view))
  }
  
  func onSignoutSuccess() {
    signoutCompletion()
  }
  
  private func pop() {
    _ = destinations.popLast()
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
