//
//  Support&FeedbackView.swift
//  Tripsmory
//
//  Created by CatMeox on 25/6/2566 BE.
//

import SwiftUI

struct Support_FeedbackView: View {
  @Environment(\.dismiss) var dismiss
  
    var body: some View {
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
            
            Text("Support & Feedback")
              .font(.custom("Jost", size: 24))
              .bold()
              .foregroundColor(Color("greenDark"))
            
            Spacer()
          }
        }
        .padding(.vertical, 12)
        
        Text("In order to resolve a complaint regarding the Service or to receive further information regarding use of the Services,")
        
        Text("please contact us at:")
          .padding(.bottom, 12)
        
        Text("Tripsmory")
        Text("___________")
        Text("tripsmoryapp@gmail.com")
        
        Spacer()
      }
      .font(.custom("Jost", size: 16))
      .foregroundColor(Color("appBlack"))
      .padding(.horizontal, 36)
      .preferredColorScheme(.light)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color("appWhite"))
    }
}

struct Support_FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        Support_FeedbackView()
    }
}
