//
//  BottomSheetCalendarView.swift
//  Tripsmory
//
//  Created by CatMeox on 21/6/2566 BE.
//

import SwiftUI

struct BottomSheetCalendarView: View {
  
  @Binding var isShowingCalendarView: Bool
  @Binding var date: Date
  
  var body: some View {
    ZStack(alignment: .bottom) {
      if isShowingCalendarView {
        Color.black
          .opacity(0.3)
          .ignoresSafeArea()
          .onTapGesture {
            isShowingCalendarView.toggle()
          }
        
        CalendarView(date: $date, isDatePickerShown: $isShowingCalendarView)
          .padding(.bottom, 42)
          .transition(.move(edge: .bottom))
          .background(Color("appWhite"))
          .cornerRadius(20, corners: [.topLeft, .topRight])
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    .ignoresSafeArea()
    .animation(.easeOut , value: isShowingCalendarView)
  }
}

extension View {
  func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
    clipShape( RoundedCorners(radius: radius, corners: corners) )
  }
}

struct RoundedCorners: Shape {
  
  var radius: CGFloat = .infinity
  var corners: UIRectCorner = .allCorners
  
  func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    return Path(path.cgPath)
  }
}
