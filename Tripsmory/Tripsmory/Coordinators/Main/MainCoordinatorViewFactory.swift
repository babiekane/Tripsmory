//
//  MainCoordinatorViewFactory.swift
//  Tripsmory
//
//  Created by yossa on 21/8/2566 BE.
//

import SwiftUI

protocol MainCoordinatorViewFactory {
  func makeMainRoot(
    onTripSelected: @escaping (TripListItem) -> Void,
    onSettingsSelected: @escaping () -> Void)
    -> AnyView
  func makeMainTripDetail(
    for item: TripListItem,
    onEdit: @escaping (TripDetail) -> Void)
    -> AnyView
  func makeMainEditTrip(
    for detail: TripDetail,
    onUpdated: @escaping () -> Void,
    onDeleted: @escaping () -> Void,
    onCancel: @escaping () -> Void)
    -> AnyView
  func makeMainSettings(
    onResetPasswordSelected: @escaping () -> Void,
    onManageAccountSelected: @escaping () -> Void,
    onPrivacyPolicySelected: @escaping () -> Void,
    onSupportAndFeedbackSelected: @escaping () -> Void,
    onSignoutSuccess: @escaping () -> Void)
    -> AnyView
  func makeMainResetPassword(onResetPasswordSuccess: @escaping () -> Void) -> AnyView
  func makeMainManageAccount(onUserDeleted: @escaping () -> Void) -> AnyView
  func makeMainPrivacyPolicy() -> AnyView
  func makeMainSupportAndFeedback() -> AnyView
}
