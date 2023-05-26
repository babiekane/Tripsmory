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
    
  var startState = StartState.start
  
  var body: some View {
    switch startState {
    case .start:
      StartView()
    case .signUp:
      SignUpView(viewModel: AuthViewModel())
    case .logIn:
      LoginView(viewModel: AuthViewModel())
    }
  }
}

struct StartCoordinatorView_Previews: PreviewProvider {
  static var previews: some View {
    StartCoordinatorView()
  }
}
