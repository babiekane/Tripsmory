//
//  TripDetailUpdater.swift
//  Tripsmory
//
//  Created by yossa on 24/8/2566 BE.
//

import Foundation

class TripDetailUpdater {
  
  var updatable: TripDetailUpdatable?
  
  func beginUpdate() {
    updatable?.updateDetail()
  }
}

protocol TripDetailUpdatable {
  func updateDetail()
}

extension TripDetailViewModel: TripDetailUpdatable {
  func updateDetail() {
    showTripDetails()
  }
}
