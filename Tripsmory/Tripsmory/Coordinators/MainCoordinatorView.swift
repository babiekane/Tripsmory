//
//  MainCoordinatorView.swift
//  Tripsmory
//
//  Created by CatMeox on 8/5/2566 BE.
//

import SwiftUI

struct MainCoordinatorView: View {
  
  @State var path: [MainDestination] = []
  @StateObject var tripDetailViewModel = TripDetailViewModel()
  
  var body: some View {
    NavigationStack(path: $path) {
      TripListView(viewModel: TripListViewModel(onTripSelected: { trip in
        path.append(MainDestination(tripID: trip.id))
      }))
        .navigationDestination(for: MainDestination.self) { destination in
          makeTripDetailView(for: destination)
        }
    }
  }
  
  /// Create TripDetailView as a separate function to prevent SwiftUI build error
  func makeTripDetailView(for destination: MainDestination) -> some View {
    tripDetailViewModel.tripID = destination.tripID
    return TripDetailView(viewModel: tripDetailViewModel)
      .toolbar(.hidden)
  }
}

struct MainDestination: Hashable {
  let tripID: String
}

struct MainCoordinatorView_Previews: PreviewProvider {
  static var previews: some View {
    RootView()
  }
}
