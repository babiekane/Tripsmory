//
//  Log in.swift
//  Tripsmory
//
//  Created by CatMeox on 23/5/2566 BE.
//

import SwiftUI
import GoogleSignInSwift


struct SignUpView: View {

  @Binding var state: StartState
  @EnvironmentObject var viewModel: AuthViewModel
  
  @State var email: String = ""
  @State var password: String = ""
  @State var showPassword: Bool = false
  
  var body: some View {
    NavigationStack {
      ZStack {
        
        BackgroundSignUp()
        
        VStack {
          Spacer()
          
          VStack(alignment: .center, spacing: 0) {
            TextField("Email", text: $email)
              .font(.custom("Jost", size: 16))
              .foregroundColor(Color("greenDark"))
              .padding(8)
              .keyboardType(.emailAddress)
            Rectangle()
              .fill(Color("greenMedium").opacity(0.5))
              .frame(width: 350, height: 1)
              .padding(.bottom, 26)
            
            HStack {
              Group {
                if showPassword {
                  TextField("Password", text: $password)
                    .font(.custom("Jost", size: 16))
                    .foregroundColor(Color("greenDark"))
                    .padding(8)
                } else {
                  SecureField("Password", text: $password)
                    .font(.custom("Jost", size: 16))
                    .foregroundColor(Color("greenDark"))
                    .padding(8)
                }
              }
              
              Button(action: {
                showPassword.toggle()
              }) {
                Image(systemName: self.showPassword ? "eye" : "eye.slash")
                  .accentColor(.gray)
              }
            }
            
            Rectangle()
              .fill(Color("greenMedium").opacity(0.5))
              .frame(width: 350, height: 1)
          }
          .textInputAutocapitalization(.never)
          .autocorrectionDisabled()
          .padding(.bottom, 32)
          .padding(.horizontal, 40)
          
          if viewModel.loading {
            ProgressView()
              .tint(Color("whiteEgg"))
              .frame(width: 285, height: 70)
              .background(Color("greenMedium"))
              .clipShape(Capsule())
              .padding(.bottom, 32)
          } else {
            Button {
              viewModel.signUp(email: email, password: password)
            } label: {
              Text("Create Account")
                .font(.custom("Jost", size: 24))
                .bold()
                .foregroundColor(Color("whiteEgg"))
                .frame(width: 285, height: 70)
                .background(Color("greenMedium"))
                .clipShape(Capsule())
            }
            .padding(.bottom, 32)
          }
          
          Text("or continue with".uppercased())
            .font(.custom("Jost", size: 16))
            .foregroundColor(Color("greenDark").opacity(0.5))
            .padding(.bottom, 8)
          
          HStack(alignment: .center, spacing: 30) {
            Button {
              viewModel.logInWithFacebook()
            } label: {
              Image("Facebook")
                .resizable()
                .frame(width: 30, height: 30)
            }
            
            Button {
              viewModel.logInWithGoogle()
            } label: {
              Image("Gmail")
                .resizable()
                .frame(width: 35, height: 30)
            }
          }
          .padding(.bottom, 32)
          
          Text("Already a traveler?")
            .font(.custom("Jost", size: 16))
            .foregroundColor(Color("greenDark").opacity(0.5))
            .padding(.bottom, 8)

          Button {
            state = .logIn
          } label: {
            Text("Login")
              .font(.custom("Jost", size: 16))
              .bold()
              .foregroundColor(Color("greenMedium"))
              .padding(.bottom, 96)
          }
        }
      }
      .background(Color("appWhite"))
      .frame(width: .infinity, height: .infinity)
    }
  }
}

struct SignUp_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      SignUpView(state: .constant(.start))
        .environmentObject(AuthViewModel())
    }
  }
}

struct BackgroundSignUp: View {
  var body: some View {
    VStack {
      HStack {
        Image("LoginTop")
        
        Spacer()
      }
      
      Spacer()
      
      HStack {
        Image("LoginBot")
        
        Spacer()
      }
    }
    .ignoresSafeArea()
  }
}
