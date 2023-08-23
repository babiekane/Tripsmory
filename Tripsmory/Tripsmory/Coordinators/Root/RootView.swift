//
//  RootView.swift
//  Tripsmory
//
//  Created by CatMeox on 24/5/2566 BE.
//

import SwiftUI

struct RootView: View {
  
  @ObservedObject var viewModel: RootViewModel
  
  var body: some View {
    let factory = viewModel.factory
    
    VStack {
      if viewModel.isLoggedIn {
        factory.makeRootMainFlow(onSignoutSuccess: viewModel.onSignoutSuccess)
      } else {
        factory.makeRootStartFlow(onAuthSuccess: viewModel.onAuthSuccess)
      }
    }
    .onAppear(perform: viewModel.onAppear)
  }
}
