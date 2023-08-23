//
//  SignupView+Previews.swift
//  Tripsmory
//
//  Created by yossa on 22/8/2566 BE.
//

import SwiftUI

struct Signup_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      SignupView(viewModel: SignupViewModel(onSignupSuccess: {}, onPressLogin: {}))
    }
  }
}
