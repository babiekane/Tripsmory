//
//  StartCoordinatorView.swift
//  Tripsmory
//
//  Created by CatMeox on 24/5/2566 BE.
//

import SwiftUI

struct StartCoordinatorView: View {
  
  init(viewModel: StartCoordinatorViewModel) {
    self.viewModel = viewModel
    state = viewModel.state
  }
  
  @ObservedObject var viewModel: StartCoordinatorViewModel
  
  @State private var state: StartState
  
  var body: some View {
    let factory = viewModel.factory
    
    VStack {
      switch state {
      case .start:
        factory.makeStartRoot(completion: viewModel.onStartCompleted)
      case .signup:
        factory.makeStartSignup(onSignupSuccess: viewModel.onSignupSuccess, onPressLogin: viewModel.onLoginPressed)
      case .login:
        factory.makeStartLogin(onLoginSuccess: viewModel.onLoginSuccess, onPressSignup: viewModel.onSignupPressed)
      }
    }
    .onChange(of: viewModel.state) { newValue in
      withAnimation(.easeOut) {
        state = newValue
      }
    }
  }
}
