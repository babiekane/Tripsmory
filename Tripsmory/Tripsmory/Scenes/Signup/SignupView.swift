//
//  Log in.swift
//  Tripsmory
//
//  Created by CatMeox on 23/5/2566 BE.
//

import SwiftUI
import GoogleSignInSwift
import AuthenticationServices

struct SignupView: View {
  
  @ObservedObject var viewModel: SignupViewModel
  
  @State var email: String = ""
  @State var password: String = ""
  @State var showPassword: Bool = false
  
  @State var showAlert: Bool = false
  
  var body: some View {
    GeometryReader { geo in
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
                .frame(width: geo.size.width - 72, height: 1)
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
                .frame(width: geo.size.width - 72, height: 1)
            }
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .padding(.bottom, 32)
            .padding(.horizontal, 64)
            
            if viewModel.isLoading {
              ProgressView()
                .tint(Color("whiteEgg"))
                .frame(width: geo.size.width / 1.6, height: 70)
                .background(Color("greenMedium"))
                .clipShape(Capsule())
                .padding(.bottom, 32)
            } else {
              Button {
                if email.isEmpty || password.isEmpty {
                  showAlert = true
                } else {
                  viewModel.signUp(email: email, password: password)
                }
              } label: {
                Text("Create Account")
                  .font(.custom("Jost", size: 24))
                  .bold()
                  .foregroundColor(Color("whiteEgg"))
                  .frame(width: geo.size.width / 1.6, height: 70)
                  .background(Color("greenMedium"))
                  .clipShape(Capsule())
              }
              .padding(.bottom, 32)
              .alert(isPresented: $showAlert) {
                Alert(
                  title: Text("Unable to create account"),
                  message: Text("Please fill email and password."),
                  dismissButton: .default(Text("OK"))
                )
              }
            }
            
            Text("or continue with".uppercased())
              .font(.custom("Jost", size: 16))
              .foregroundColor(Color("greenDark").opacity(0.5))
              .padding(.bottom, 8)
            
            HStack(alignment: .center, spacing: 20) {
              Button {
                viewModel.logInWithApple()
              } label: {
                Image("Apple")
                  .resizable()
                  .frame(width: 30, height: 30)
              }
              
              //            Button {
              //              viewModel.logInWithFacebook()
              //            } label: {
              //              Image("Facebook")
              //                .resizable()
              //                .frame(width: 30, height: 30)
              //            }
              //
              //            Button {
              //              viewModel.logInWithTwitter()
              //            } label: {
              //              Image("Twitter")
              //                .resizable()
              //                .frame(width: 35, height: 30)
              //            }
              
              Button {
                viewModel.logInWithGoogle()
              } label: {
                Image("Gmail")
                  .resizable()
                  .frame(width: 30, height: 30)
              }
            }
            .padding(.bottom, 32)
            
            Text("Already a traveler?")
              .font(.custom("Jost", size: 16))
              .foregroundColor(Color("greenDark").opacity(0.5))
              .padding(.bottom, 8)
            
            Button {
              viewModel.proceedToLogin()
            } label: {
              Text("Login")
                .font(.custom("Jost", size: 16))
                .bold()
                .foregroundColor(Color("greenMedium"))
                .padding(.bottom, 90)
            }
          }
        }
        .ignoresSafeArea(.keyboard)
        .background(Color("appWhite"))
        .preferredColorScheme(.light)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      }
    }
  }
}

struct BackgroundSignUp: View {
  var body: some View {
    VStack(spacing: 0) {
        Image("LoginTop")
      
      Spacer()

        Image("LoginBot")
    }
    .ignoresSafeArea()
  }
}
