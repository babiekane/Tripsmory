//
//  Login.swift
//  Tripsmory
//
//  Created by CatMeox on 23/5/2566 BE.
//

import SwiftUI

struct Login: View {
  var body: some View {
    LoginView()
  }
}

struct Login_Previews: PreviewProvider {
  static var previews: some View {
    Login()
  }
}

struct LoginView: View {
  
  @State var email: String = ""
  @State var password: String = ""

  var body: some View {
    ZStack {
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
      
      VStack {
        Spacer()
        
        VStack(alignment: .center, spacing: 0) {
          TextField("Email", text: $email)
            .font(.custom("Jost", size: 16))
            .foregroundColor(Color("greenDark"))
            .padding(8)
          Rectangle()
            .fill(Color("greenMedium").opacity(0.5))
            .frame(width: 350, height: 1)
            .padding(.bottom, 26)
          
          TextField("Password", text: $password)
            .font(.custom("Jost", size: 16))
            .foregroundColor(Color("greenDark"))
            .padding(8)
          Rectangle()
            .fill(Color("greenMedium").opacity(0.5))
            .frame(width: 350, height: 1)
        }
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled()
        .padding(.bottom, 32)
        .padding(.horizontal, 40)
        
        Button {
          // TODO
        } label: {
          Text("Login")
            .font(.custom("Jost", size: 24))
            .bold()
            .foregroundColor(Color("whiteEgg"))
            .frame(width: 285, height: 70)
            .background(Color("greenMedium"))
            .clipShape(Capsule())
            .padding(.bottom, 300)
        }
      }
    }
    .background(Color("appWhite"))
    .frame(width: .infinity, height: .infinity)
  }
}
