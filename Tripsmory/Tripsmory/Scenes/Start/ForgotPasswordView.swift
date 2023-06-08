//
//  ForgotPasswordView.swift
//  Tripsmory
//
//  Created by CatMeox on 3/6/2566 BE.
//

import SwiftUI

struct ForgotPasswordView: View {
  
  @State var email: String = ""
  @EnvironmentObject var viewModel: AuthViewModel
  @Environment(\.dismiss) var dismiss
    
  var body: some View {
    VStack {
      Text("Forgot your password?")
        .font(.custom("Jost", size: 28))
        .bold()
        .foregroundColor(Color("greenMedium"))
        .padding(.bottom, 12)
      VStack {
        Text("Enter your registered email below")
        Text("to receive password reset instruction")
      }
      .font(.custom("Jost", size: 16))
      .foregroundColor(Color("greenDark"))
      .padding(.bottom, 32)
      
      Image("Plane")
        .resizable()
        .frame(width: 200, height: 300)
        .padding(.bottom, 32)
      
      TextField("Email", text: $email)
        .font(.custom("Jost", size: 16))
        .foregroundColor(Color("greenDark"))
        .padding(8)
        .padding(.horizontal, 36)
      Rectangle()
        .fill(Color("greenMedium").opacity(0.5))
        .frame(width: 350, height: 1)
        .padding(.bottom, 8)
      
      HStack {
        Text("Remember password?")
          .font(.custom("Jost", size: 16))
          .foregroundColor(Color("greenDark"))
        Button {
          dismiss()
        } label: {
          Text("Login")
            .font(.custom("Jost", size: 16))
            .bold()
            .foregroundColor(Color("greenMedium"))
        }
      }
      .padding(.bottom, 32)
      
      Button {
        viewModel.forgotPassword(email: email)
        dismiss()
      } label: {
        Text("Send")
          .font(.custom("Jost", size: 24))
          .bold()
          .foregroundColor(Color("whiteEgg"))
          .frame(width: 285, height: 70)
          .background(Color("greenMedium"))
          .clipShape(Capsule())
      }
      
      Spacer()
    }
    .padding(.top, 36)
  }
}

struct ForgotPasswordView_Previews: PreviewProvider {
  static var previews: some View {
    ForgotPasswordView()
  }
}
