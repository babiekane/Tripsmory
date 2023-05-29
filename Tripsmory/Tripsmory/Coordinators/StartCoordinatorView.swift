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
    
  @State var startState = StartState.start
  @State var animationState = StartState.start
  
  var body: some View {
    VStack {
      switch animationState {
      case .start:
        StartView(state: $startState)
      case .signUp:
        SignUpView(state: $startState)
      case .logIn:
        LoginView(state: $startState)
      }
    }
    .onChange(of: startState) { newValue in
      withAnimation {
        animationState = newValue
      }
    }
  }
}

struct StartCoordinatorView_Previews: PreviewProvider {
  static var previews: some View {
    StartCoordinatorView()
  }
}
