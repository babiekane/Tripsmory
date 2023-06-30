//
//  ManageAccView.swift
//  Tripsmory
//
//  Created by CatMeox on 23/6/2566 BE.
//

import SwiftUI

struct ManageAccView: View {
  @Environment(\.dismiss) var dismiss
  
  @EnvironmentObject var authViewModel: AuthViewModel
  
  let onDelete: () -> Void
  
  @State var showingAlert = false
  
  var body: some View {
    GeometryReader { geometry in
      VStack(alignment: .center) {
        ZStack {
          Button {
            dismiss()
          } label: {
            HStack(alignment: .center, spacing: 0) {
              Image(systemName: "chevron.backward")
                .resizable()
                .frame(width: 12, height: 18)
                .foregroundColor(Color("greenDark"))
              
              Spacer()
            }
          }
          
          HStack(alignment: .center, spacing: 0) {
            Spacer()
            
            Text("Manage account")
              .font(.custom("Jost", size: 24))
              .bold()
              .foregroundColor(Color("greenDark"))
            
            Spacer()
          }
        }
        .padding(.vertical, 12)
        
        Text("Account deletion is irreversible, permanently removing all personal information, data, and associated content.")
          .multilineTextAlignment(.center)
          .frame(width: geometry.size.width - 72)
          .font(.custom("Jost", size: 16))
          .foregroundColor(Color("appBlack"))
          .padding(.bottom, 8)
        
        Text("Recovery or access restoration is not possible after deletion.")
          .multilineTextAlignment(.center)
          .frame(width: geometry.size.width - 72)
          .font(.custom("Jost", size: 16))
          .fontWeight(.medium)
          .foregroundColor(Color("Red"))
          .padding(.bottom, 36)
        
        Image("Car")
          .resizable()
          .frame(width: 250, height: 250)
          .padding(.bottom, 36)
        
        Button {
          showingAlert = true
        } label: {
          Text("Delete account")
            .font(.custom("Jost", size: 16))
            .fontWeight(.medium)
            .frame(width: geometry.size.width - 72, height: 50)
            .foregroundColor(Color("Red"))
            .background(Color("appWhite"))
            .overlay(
              Capsule().stroke(Color("Red"), lineWidth: 2)
            )
            .clipShape(Capsule())
        }
        .padding(.vertical, 8)
        
        Spacer()
      }
      .padding(.horizontal, 36)
      .background(Color("appWhite"))
      .preferredColorScheme(.light)
      .frame(width: geometry.size.width, height: geometry.size.height)
      .alert("Are you sure to delete your account?", isPresented: $showingAlert) {
        Button("Cancel", role: .cancel) { }
        Button("Delete", role: .destructive) {
          authViewModel.deleteUser()
          onDelete()
        }
      }
      .alert(item: $authViewModel.errorMessage) { errorMessage in
        Alert(
          title: Text("Unable to delete"),
          message: Text(errorMessage),
          dismissButton: .default(Text("OK"))
        )
      }
    }
  }
}

struct ManageAccView_Previews: PreviewProvider {
    static var previews: some View {
      ManageAccView(onDelete: {})
        .environmentObject(AuthViewModel())
    }
}
