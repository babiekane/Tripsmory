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
  func makeMainSettings(onSignoutSuccess: @escaping () -> Void) -> AnyView
}
