//
//  Login.swift
//  Tripsmory
//
//  Created by CatMeox on 23/5/2566 BE.
//

import SwiftUI

struct LoginView: View {
  
  @Binding var state: StartState
  
  @State var email: String = ""
  @State var password: String = ""
  @State var showPassword: Bool = false
  
  @State var isPresented: Bool = false
  
  @State var showAlert: Bool = false

  
  @EnvironmentObject var viewModel: AuthViewModel
  
  var body: some View {
    NavigationStack {
      ZStack {
        
        BackgroundLogIn()
        
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
          .padding(.bottom, 8)
          .padding(.horizontal, 40)
          
          HStack {
            
            Spacer()
            
            Button {
              isPresented = true
            } label : {
              Text("Forgot password?")
                .font(.custom("Jost", size: 16))
                .bold()
                .foregroundColor(Color("greenDark"))
            }
            .padding(.bottom, 32)
            .padding(.trailing, 36)
          }
          
          if viewModel.loading {
            ProgressView()
              .tint(Color("whiteEgg"))
              .frame(width: 285, height: 70)
              .background(Color("greenMedium"))
              .clipShape(Capsule())
              .padding(.bottom, 32)
          } else {
            Button {
              viewModel.logIn(email: email, password: password)
            } label: {
              Text("Login")
                .font(.custom("Jost", size: 24))
                .bold()
                .foregroundColor(Color("whiteEgg"))
                .frame(width: 285, height: 70)
                .background(Color("greenMedium"))
                .clipShape(Capsule())
            }
            .padding(.bottom, 32)
          }
            
          Text("Do not have any account?")
            .font(.custom("Jost", size: 16))
            .foregroundColor(Color("greenDark").opacity(0.5))
            .padding(.bottom, 8)

          Button {
            state = .signUp
          } label: {
            Text("Sign up")
              .font(.custom("Jost", size: 16))
              .bold()
              .foregroundColor(Color("greenMedium"))
              .padding(.bottom, 96)
          }
        }
      }
      .background(Color("appWhite"))
      .preferredColorScheme(.light)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    .alert(item: $viewModel.errorMessage) { errorMessage in
      Alert(
        title: Text("Unable to login"),
        message: Text(errorMessage),
        dismissButton: .default(Text("OK"))
      )
    }
    .sheet(isPresented: $isPresented) {
      ForgotPasswordView()
    }

  }
}

struct Login_Previews: PreviewProvider {
  static var previews: some View {
    LoginView(state: .constant(.logIn))
      .environmentObject(AuthViewModel())
  }
}

struct BackgroundLogIn: View {
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

extension String: Identifiable {
  public var id: String { self }
}
