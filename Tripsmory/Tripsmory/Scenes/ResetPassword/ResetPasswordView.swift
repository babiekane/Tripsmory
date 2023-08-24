//
//  ResetPasswordView.swift
//  Tripsmory
//
//  Created by CatMeox on 23/6/2566 BE.
//

import SwiftUI

struct ResetPasswordView: View {
  
  @ObservedObject var viewModel: ResetPasswordViewModel
  
  @State var email = ""
//  @EnvironmentObject var viewModel: AuthViewModel
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    GeometryReader { geo in
      VStack(alignment: .center) {
        ZStack {
          Button {
            dismiss()
          } label: {
            HStack(alignment: .center, spacing: 0) {
              Image(systemName: "chevron.backward")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color("greenDark"))
              
              Spacer()
            }
          }
          
          HStack(alignment: .center, spacing: 0) {
            Spacer()
            
            Text("Password")
              .font(.custom("Jost", size: 24))
              .bold()
              .foregroundColor(Color("greenDark"))
            
            Spacer()
          }
        }
        .padding(.vertical, 12)
        
        HStack {
          Text("Reset password")
            .font(.custom("Jost", size: 20))
            .fontWeight(.medium)
            .foregroundColor(Color("greenDark"))
            .padding(.bottom, 12)
          
          Spacer()
        }
        
        VStack {
          Text("Enter your registered email below")
          Text("to receive password reset instruction")
        }
        .font(.custom("Jost", size: 16))
        .foregroundColor(Color("appBlack"))
        .padding(.bottom, 36)
        
        Image("Plane")
          .resizable()
          .frame(width: 163, height: 266)
          .padding(.bottom, 36)
        
        VStack(alignment: .leading, spacing: 4) {
          Text("Email")
            .font(.custom("Jost", size: 16))
            .fontWeight(.medium)
            .foregroundColor(Color("greenDark"))
          
          TextField("", text: $email)
            .textFieldStyle(OvalTextFieldStyle())
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
            .keyboardType(.emailAddress)
        }
        .padding(.bottom, 24)
        
        Button {
          viewModel.forgotPassword(email: email)
        } label: {
          Text("Send")
            .font(.custom("Jost", size: 24))
            .bold()
            .foregroundColor(Color("whiteEgg"))
            .frame(width: geo.size.width / 1.6, height: 60)
            .background(Color("greenMedium"))
            .clipShape(Capsule())
        }
        
        Spacer()
      }
    }
    .padding(.horizontal, 36)
    .background(Color("appWhite"))
    .preferredColorScheme(.light)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}
