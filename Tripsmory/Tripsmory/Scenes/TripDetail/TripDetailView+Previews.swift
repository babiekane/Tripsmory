//
//  TripDetailView+Previews.swift
//  Tripsmory
//
//  Created by yossa on 23/8/2566 BE.
//

import SwiftUI

struct TripDetailView_Previews: PreviewProvider {
  static var previews: some View {
    TripDetailView(viewModel: TripDetailViewModel(tripID: "", onEdit: { _ in }))
  }
}
