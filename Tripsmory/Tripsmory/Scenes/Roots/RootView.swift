//
//  RootView.swift
//  Tripsmory
//
//  Created by CatMeox on 24/5/2566 BE.
//

import SwiftUI

struct RootView: View {
  
   @EnvironmentObject var authManager: AuthViewModel
  
  var body: some View {
    VStack {
      if authManager.loggedIn {
        MainCoordinatorView()
      } else {
        StartCoordinatorView(authViewModel: authManager)
      }
    }
    .onAppear {
      authManager.start()
    }
  }
}

struct RootsView_Previews: PreviewProvider {
  static var previews: some View {
    RootView()
  }
}
