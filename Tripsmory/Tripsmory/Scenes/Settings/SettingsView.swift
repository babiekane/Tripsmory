//
//  SettingsView.swift
//  Tripsmory
//
//  Created by CatMeox on 26/5/2566 BE.
//

import SwiftUI

struct SettingsView: View {
  
  @ObservedObject var viewModel: AuthViewModel
  
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
      VStack {
        Text("Profile settings")
          .font(.custom("Jost", size: 24))
          .fontWeight(.semibold)
          .foregroundColor(Color("greenDark"))
        
        Button {
          viewModel.signOut()
          dismiss()
        } label: {
          Text("Log out")
            .font(.custom("Jost", size: 24))
            .fontWeight(.semibold)
            .foregroundColor(Color("greenLight"))
            .padding(.horizontal, 24)
            .padding(.vertical, 6)
            .background(Color("greenDark"))
            .clipShape(Capsule())
        }
      }
    
    .frame(width: .infinity, height: .infinity)
    .background(Color("appWhite"))
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView(viewModel: AuthViewModel())
  }
}
