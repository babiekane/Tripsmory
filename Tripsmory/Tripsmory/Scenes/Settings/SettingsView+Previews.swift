//
//  SettingsView+Previews.swift
//  Tripsmory
//
//  Created by yossa on 22/8/2566 BE.
//

import SwiftUI

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView(viewModel: SettingsViewModel(onSignoutSuccess: {}))
  }
}
