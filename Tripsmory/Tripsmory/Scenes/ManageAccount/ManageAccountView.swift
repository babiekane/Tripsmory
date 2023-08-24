//
//  ManageAccountView.swift
//  Tripsmory
//
//  Created by CatMeox on 23/6/2566 BE.
//

import SwiftUI

struct ManageAccountView: View {
  
  @ObservedObject var viewModel: ManageAccountViewModel
  
  @Environment(\.dismiss) var dismiss
  
  @State var showingAlert = false
  
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
          .frame(width: geo.size.width - 72)
          .font(.custom("Jost", size: 16))
          .foregroundColor(Color("appBlack"))
          .padding(.bottom, 8)
        
        Text("Recovery or access restoration is not possible after deletion.")
          .multilineTextAlignment(.center)
          .frame(width: geo.size.width - 72)
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
            .frame(width: geo.size.width - 36, height: 50)
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
    }
      .padding(.horizontal, 36)
      .background(Color("appWhite"))
      .preferredColorScheme(.light)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .alert("Are you sure to delete your account?", isPresented: $showingAlert) {
        Button("Cancel", role: .cancel) { }
        Button("Delete", role: .destructive) {
          viewModel.deleteUser()
        }
      }
      .alert(item: $viewModel.errorMessage) { errorMessage in
        Alert(
          title: Text("Unable to delete"),
          message: Text(errorMessage),
          dismissButton: .default(Text("OK"))
        )
      }
    
  }
}
