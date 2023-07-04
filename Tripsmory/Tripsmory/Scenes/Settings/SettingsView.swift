//
//  SettingsView.swift
//  Tripsmory
//
//  Created by CatMeox on 22/6/2566 BE.
//

import SwiftUI

struct SettingsView: View {
  @State var showingAlert = false
  @EnvironmentObject var authViewModel: AuthViewModel
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    GeometryReader { geo in
      VStack(alignment: .leading) {
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
            
            Text("Settings")
              .font(.custom("Jost", size: 24))
              .bold()
              .foregroundColor(Color("greenDark"))
            
            Spacer()
          }
        }
        .padding(.vertical, 12)
        
        
        Text("Accounts")
          .font(.custom("Jost", size: 16))
          .fontWeight(.medium)
          .foregroundColor(Color("greenDark"))
          .padding(.bottom, 12)
        
        Group {
          //          NavigationLink {
          //            ProfileView()
          //              .navigationBarBackButtonHidden(true)
          //          } label: {
          //            HStack(spacing: 16) {
          //              Image(systemName: "person")
          //                .resizable()
          //                .frame(width: 20, height: 20)
          //              Text("Profile")
          //                .font(.custom("Jost", size: 16))
          //                .fontWeight(.medium)
          //            }
          //            .foregroundColor(Color("greenMedium"))
          //          }
          //          .padding(.bottom, 24)
          
          NavigationLink {
            ResetPasswordView()
              .navigationBarBackButtonHidden(true)
          } label: {
            HStack(spacing: 16) {
              Image(systemName: "lock")
                .resizable()
                .frame(width: 18, height: 20)
              Text("Password")
                .font(.custom("Jost", size: 16))
                .fontWeight(.medium)
            }
            .foregroundColor(Color("greenMedium"))
          }
          .padding(.bottom, 24)
          
          NavigationLink {
            ManageAccView(onDelete: {})
              .navigationBarBackButtonHidden(true)
          } label: {
            HStack(spacing: 16) {
              Image(systemName: "pencil.line")
                .resizable()
                .frame(width: 20, height: 20)
              Text("Manage account")
                .font(.custom("Jost", size: 16))
                .fontWeight(.medium)
            }
            .foregroundColor(Color("greenMedium"))
          }
          .padding(.bottom, 60)
        }
        .padding(.leading, 12)
        
        Text("Others")
          .font(.custom("Jost", size: 16))
          .fontWeight(.medium)
          .foregroundColor(Color("greenDark"))
          .padding(.bottom, 12)
        
        Group {
          NavigationLink {
            PrivacyPolicyView()
              .navigationBarBackButtonHidden(true)
          } label: {
            HStack(spacing: 16) {
              Image(systemName: "checkmark.shield")
                .resizable()
                .frame(width: 20, height: 20)
              Text("Privacy policy")
                .font(.custom("Jost", size: 16))
                .fontWeight(.medium)
            }
            .foregroundColor(Color("greenMedium"))
          }
          .padding(.bottom, 24)
          
          NavigationLink {
            Support_FeedbackView()
              .navigationBarBackButtonHidden(true)
          }label: {
            HStack(spacing: 16) {
              Image(systemName: "ellipsis.bubble")
                .resizable()
                .frame(width: 20, height: 20)
              Text("Support & Feedback")
                .font(.custom("Jost", size: 16))
                .fontWeight(.medium)
            }
            .foregroundColor(Color("greenMedium"))
          }
        }
        .padding(.leading, 12)
        
        Spacer()
        
        Button {
          showingAlert = true
        } label: {
          HStack {
            Image(systemName: "rectangle.portrait.and.arrow.right")
            Text("Log out")
              .font(.custom("Jost", size: 16))
              .fontWeight(.medium)
          }
          .frame(width: geo.size.width - 72, height: 50)
          .foregroundColor(Color("appWhite"))
          .background(Color("greenMedium"))
          .clipShape(Capsule())
        }
        .alert("Are you sure to log out?", isPresented: $showingAlert) {
          Button("Cancel", role: .cancel) { }
          Button("Log out", role: .destructive) {
            authViewModel.signOut()
          }
        }
        .padding(.bottom, 36)
      }
      .padding(.horizontal, 36)
      .background(Color("appWhite"))
      .preferredColorScheme(.light)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
  }
}
