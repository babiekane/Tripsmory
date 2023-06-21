//
//  CalendarView.swift
//  Tripsmory
//
//  Created by CatMeox on 21/6/2566 BE.
//

import SwiftUI

struct CalendarView: View {
  @Binding var date: Date
  @Binding var isDatePickerShown : Bool
  
  var body: some View {
    DatePicker(
      "Start Date",
      selection: $date,
      displayedComponents: [.date]
    )
    .onChange(of: date, perform: { _ in
        self.isDatePickerShown = false
    })
    .datePickerStyle(.graphical)
    .padding(16)
    .background(Color("appWhite"))
    .accentColor(Color("greenMedium"))
    .preferredColorScheme(.light)
  }
}

struct CalendarView_Previews: PreviewProvider {
  static var previews: some View {
    CalendarView(date: .constant(Date()), isDatePickerShown: .constant(false))
  }
}
