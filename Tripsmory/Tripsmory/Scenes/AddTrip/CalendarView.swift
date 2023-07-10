//
//  CalendarView.swift
//  Tripsmory
//
//  Created by CatMeox on 21/6/2566 BE.
//

import SwiftUI

struct CalendarView: View {
  init(date: Binding<Date?>, isDatePickerShown: Binding<Bool>) {
    self._date = date
    self._isDatePickerShown = isDatePickerShown
    self._pickerDate = State(initialValue: date.wrappedValue ?? Date.now)
  }
  
  @Binding var date: Date?
  @Binding var isDatePickerShown: Bool
  
  @State private var pickerDate: Date
  
  var body: some View {
    DatePicker(
      "Start Date",
      selection: $pickerDate,
      displayedComponents: [.date]
    )
    .onChange(of: pickerDate, perform: { newValue in
      date = newValue
      self.isDatePickerShown = false
    })
    .datePickerStyle(.graphical)
    .padding(24)
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
