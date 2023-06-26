//
//  ProfileView.swift
//  Tripsmory
//
//  Created by CatMeox on 23/6/2566 BE.
//

import SwiftUI

struct ProfileView: View {
  
  @State var name = ""
  @State var dateOfBirth = ""
  @State var gender = ""
  
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    GeometryReader { geometry in
      VStack(alignment: .leading) {
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
            
            Text("Profile")
              .font(.custom("Jost", size: 24))
              .bold()
              .foregroundColor(Color("greenDark"))
            
            Spacer()
          }
        }
        .padding(.vertical, 12)
        
        HStack {
          Spacer()
          Button {
            // TODO
          } label: {
            ZStack {
              Circle()
                .fill(Color("greenLight"))
                .frame(width: 130)
              Image(systemName: "camera")
                .resizable()
                .frame(width: 30, height: 25)
                .foregroundColor(Color("greenDark"))
            }
          }
          Spacer()
        }
        .padding(.bottom, 40)
        
        VStack(spacing: 20) {
          VStack(alignment: .leading, spacing: 4) {
            Text("Name")
              .font(.custom("Jost", size: 16))
              .fontWeight(.medium)
              .foregroundColor(Color("greenDark"))
            
            TextField("", text: $name)
              .textFieldStyle(OvalTextFieldStyle())
              .disableAutocorrection(true)
          }
          
          VStack(alignment: .leading, spacing: 4) {
            Text("Date of birth")
              .font(.custom("Jost", size: 16))
              .fontWeight(.medium)
              .foregroundColor(Color("greenDark"))
            
            Button {
              //              withAnimation {
              //                isShowingCalendarView.toggle()
              //              }
              //              self.isDatePickerShown = true
            } label: {
              HStack {
                Text("\(dateOfBirth)")
                  .padding(.leading, 16)
                  .foregroundColor(Color("appBlack"))
                  .frame(width: geometry.size.width - 72 - 30, height: 40, alignment: .leading)
                  .background((Color("greenLight").opacity(0.5)))
                  .clipShape(Capsule())
                Image(systemName: "calendar")
                  .foregroundColor(Color("greenMedium"))
              }
            }
          }
          
          VStack(alignment: .leading, spacing: 4) {
            Text("Gender")
              .font(.custom("Jost", size: 16))
              .fontWeight(.medium)
              .foregroundColor(Color("greenDark"))
            
            TextField("", text: $gender)
              .textFieldStyle(OvalTextFieldStyle())
              .disableAutocorrection(true)
          }
        }
        
        Spacer()
        
      }
      .padding(.horizontal, 36)
      .background(Color("appWhite"))
      .preferredColorScheme(.light)
      .frame(width: geometry.size.width, height: geometry.size.height)
    }
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
  }
}
