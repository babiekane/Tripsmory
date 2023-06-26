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
        path.append(.tripDetail(trip.id))
      }, onSettingsSelected: {
        path.append(.settings)
      }))
        .navigationDestination(for: MainDestination.self) { destination in
          switch destination {
          case .tripDetail(let tripID):
            makeTripDetailView(for: tripID)
            
          case .settings:
            SettingsView()
              .toolbar(.hidden)
          }
        }
    }
  }
  
  /// Create TripDetailView as a separate function to prevent SwiftUI build error
  func makeTripDetailView(for tripID: String) -> some View {
    tripDetailViewModel.tripID = tripID
    return TripDetailView(viewModel: tripDetailViewModel)
      .toolbar(.hidden)
  }
}

//struct MainDestination: Hashable {
//  let tripID: String
//}

enum MainDestination: Hashable {
  case tripDetail(String)
  case settings
  
  static func == (lhs: MainDestination, rhs: MainDestination) -> Bool {
    switch (lhs, rhs) {
    case (.tripDetail(let leftID), .tripDetail(let rightID)):
      if leftID == rightID {
        return true
      } else {
        return false
      }
      
    case (.settings, .settings):
      return true
      
    default:
      return false
    }
    
//    if case .tripDetail(let leftID) = lhs, case .tripDetail(let rightID) = rhs {
//      if leftID == rightID {
//        return true
//      } else {
//        return false
//      }
//    } else {
//      return false
//    }
  }
  
  func hash(into hasher: inout Hasher) {
    
  }
}

struct MainCoordinatorView_Previews: PreviewProvider {
  static var previews: some View {
    RootView()
  }
}
