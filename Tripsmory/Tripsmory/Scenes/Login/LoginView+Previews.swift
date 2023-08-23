//
//  LoginView+Previews.swift
//  Tripsmory
//
//  Created by yossa on 22/8/2566 BE.
//

import SwiftUI

struct Login_Previews: PreviewProvider {
  static var previews: some View {
    LoginView(viewModel: LoginViewModel(onLoginSuccess: {}, onPressSignup: {}))
  }
}
