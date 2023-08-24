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
    let viewModel = TripDetailViewModel(tripID: item.id, onEdit: onEdit)
    let view = TripDetailView(viewModel: viewModel)
      .navigationBarHidden(true)
    return AnyView(view)
  }
  
  func makeMainEditTrip(for detail: TripDetail, onUpdated: @escaping () -> Void, onDeleted: @escaping () -> Void, onCancel: @escaping () -> Void) -> AnyView {
    let viewModel = EditTripViewModel(detail: detail, onUpdated: onUpdated, onDeleted: onDeleted, onCancel: onCancel)
    let view = EditTripView(viewModel: viewModel)
    return AnyView(view)
  }
  
  func makeMainSettings(
    onResetPasswordSelected: @escaping () -> Void,
    onManageAccountSelected: @escaping () -> Void,
    onPrivacyPolicySelected: @escaping () -> Void,
    onSupportAndFeedbackSelected: @escaping () -> Void,
    onSignoutSuccess: @escaping () -> Void)
  -> AnyView
  {
    let viewModel = SettingsViewModel(
      onResetPasswordSelected: onResetPasswordSelected,
      onManageAccountSelected: onManageAccountSelected,
      onPrivacyPolicySelected: onPrivacyPolicySelected,
      onSupportAndFeedbackSelected: onSupportAndFeedbackSelected,
      onSignoutSuccess: onSignoutSuccess)
    let view = SettingsView(viewModel: viewModel)
      .navigationBarHidden(true)
    return AnyView(view)
  }
  
  func makeMainResetPassword(onResetPasswordSuccess: @escaping () -> Void) -> AnyView {
    let viewModel = ResetPasswordViewModel(onResetPasswordSuccess: onResetPasswordSuccess)
    let view = ResetPasswordView(viewModel: viewModel)
      .navigationBarBackButtonHidden(true)
    return AnyView(view)
  }
  
  func makeMainManageAccount(onUserDeleted: @escaping () -> Void) -> AnyView {
    let viewModel = ManageAccountViewModel(onDelete: onUserDeleted)
    let view = ManageAccountView(viewModel: viewModel)
      .navigationBarBackButtonHidden(true)
    return AnyView(view)
  }
  
  func makeMainPrivacyPolicy() -> AnyView {
    let view = PrivacyPolicyView()
      .navigationBarBackButtonHidden(true)
    return AnyView(view)
  }
  
  func makeMainSupportAndFeedback() -> AnyView {
    let view = SupportAndFeedbackView()
      .navigationBarBackButtonHidden(true)
    return AnyView(view)
  }
}
