//
//  Start.swift
//  Tripsmory
//
//  Created by CatMeox on 23/5/2566 BE.
//

import SwiftUI

struct StartView: View {
  var body: some View {
    
      WelcomeView()
    
  }
}

struct Start_Previews: PreviewProvider {
  static var previews: some View {
    StartView()
  }
}

struct WelcomeView: View {
  
  var body: some View {
    NavigationStack {
      ZStack {
        VStack {
          
          HStack {
            Image("StartTop")
            
            Spacer()
          }
          Spacer()
          
          HStack {
            Spacer()
            
            Image("StartBot")
          }
        }
        .ignoresSafeArea()
        
        VStack {
          
          Spacer()
          
          Image("Stuff")
            .padding(.bottom, 36)
          
          Text("Welcome our travelers")
            .font(.custom("Jost", size: 28))
            .bold()
            .foregroundColor(Color("greenMedium"))
          
          Text("Let's create your memory".uppercased())
            .font(.custom("Jost", size: 16))
            .foregroundColor(Color("greenDark"))
            .padding(.bottom, 100)
          
          NavigationLink {
            SignUpView(viewModel: AuthViewModel())
          } label: {
            Text("Get Started")
              .font(.custom("Jost", size: 24))
              .bold()
              .foregroundColor(Color("whiteEgg"))
              .frame(width: 285, height: 70)
              .background(Color("greenMedium"))
              .clipShape(Capsule())
              .padding(.bottom, 120)
          }
        }
      }
    }
    .background(Color("appWhite"))
    .frame(width: .infinity, height: .infinity)
  }
}