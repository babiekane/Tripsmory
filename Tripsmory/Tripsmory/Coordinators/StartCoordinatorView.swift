//
//  StartCoordinatorView.swift
//  Tripsmory
//
//  Created by CatMeox on 24/5/2566 BE.
//

import SwiftUI

enum StartState {
  case start, signUp, logIn
}

struct StartCoordinatorView: View {
  @ObservedObject var authViewModel: AuthViewModel
  
  var body: some View {
    VStack {
      switch authViewModel.animationState {
      case .start:
        StartView(state: $authViewModel.startState)
      case .signUp:
        SignUpView(state: $authViewModel.startState)
      case .logIn:
        LoginView(state: $authViewModel.startState)
      }
    }
    .onChange(of: authViewModel.startState) { newValue in
      withAnimation(.easeOut) {
        authViewModel.animationState = newValue
      }
    }
  }
}

struct StartCoordinatorView_Previews: PreviewProvider {
  static var previews: some View {
    StartCoordinatorView(authViewModel: AuthViewModel())
  }
}
