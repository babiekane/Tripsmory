//
//  TripListView.swift
//  Tripsmory
//
//  Created by CatMeox on 28/3/2566 BE.
//

import SwiftUI

struct TripListView: View {
  
  @ObservedObject var viewModel: TripListViewModel
  @StateObject var addTripViewModel = AddTripViewModel()
  
  @State var showingAlert = false
  
  var body: some View {
    GeometryReader { geo in
      ZStack {
        ScrollView {
          VStack(spacing: 0) {
            HStack(spacing: 0) {
              Text("TRIPS")
                .font(.custom("Jost", size: 36))
                .bold()
                .foregroundColor(Color("greenDark"))
                .padding(.leading, 36)
                .padding(.bottom, 8)
              
              Spacer()
              
              Button {
                viewModel.onSettingsSelected()
              } label: {
                Image(systemName: "gear")
                  .resizable()
                  .frame(width: 30, height: 30)
                  .foregroundColor(Color("greenMedium"))
                  .padding(.trailing, 36)
              }
            }
            
            if viewModel.isLoading {
              VStack {
                ProgressView("Loading your trips")
                  .font(.custom("Jost", size: 20))
                  .tint(Color("blueDark"))
                  .foregroundColor(Color("greenDark"))
              }
            } else {
              if viewModel.trips.isEmpty {
                VStack {
                  Image("Bag")
                    .resizable()
                    .frame(width: 300, height: 280)
                    .padding(.top, 36)
                  Text("Add your first memory")
                    .font(.custom("Jost", size: 20))
                    .foregroundColor(Color("greenDark"))
                }
              } else {
                ForEach(viewModel.trips) { trip in
                  Button {
                    viewModel.onTripSelected(trip)
                  } label: {
                    TripListItemView(trip: trip,
                                     width: geo.size.width,
                                     height: geo .size.height)
                  }
                }
              }
            }
          }
        }
        
        VStack(alignment: .leading) {
          Spacer()
          
          HStack {
            Spacer()
            
            Button {
              self.viewModel.isPresented = true
            } label: {
              Image("Plus")
                .resizable()
                .frame(width: 16, height: 16)
                .padding(20)
                .background(Color("blueDark"))
                .clipShape(Circle())
                .shadow(color: Color("blueDark"), radius: 6)
                .padding(.trailing, 24)
                .padding(.vertical, 8)
            }
          }
        }
      }
    }
    .background(Color("appWhite"))
    .preferredColorScheme(.light)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .onAppear {
      viewModel.fetchTrips()
    }
    .refreshable {
      viewModel.fetchTrips()
    }
    .fullScreenCover(isPresented: $viewModel.isPresented) {
      AddTripView(viewModel: addTripViewModel, isShowingCalendarView: false)
    }
  }
}

struct TripListView_Previews: PreviewProvider {
  static var previews: some View {
    TripListView(viewModel: TripListViewModel(onTripSelected: { trip in }, onSettingsSelected: {}))
  }
}

struct TripListItemView: View {
  
  let trip: TripListItem
  
  let width: Double
  let height: Double
  
  var body: some View {
    
    VStack {
      
      VStack(alignment: .leading, spacing: 0) {
        if let coverImage = trip.coverImageURL {
          AsyncImage(url: coverImage) { image in
            image
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: width - 32, height: height / 5)
              .clipped()
              .padding(.bottom, 8)
          } placeholder: {
            ProgressView()
              .tint(Color("greenDark"))
              .frame(width: width - 32, height: height / 4.75)
              .background(Color("whiteEgg"))
              .clipShape(RoundedRectangle(cornerRadius: 12))
          }
        } else {
          Image("NoImages")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: width - 32, height: height / 5)
            .padding(.vertical, 8)
            .clipped()
            .background(Color("Test1"))
            .padding(.bottom, 8)
        }
      
      HStack {
        VStack(alignment: .leading, spacing: 0) {
          Text(trip.name)
            .font(.custom("Jost", size: 16))
            .bold()
            .foregroundColor(Color("greenDark"))
            .padding(.bottom, 0)
          
          HStack(spacing: 26) {
            HStack(spacing: 4) {
              Image("Location")
                .resizable()
                .renderingMode(.template)
                .frame(width: 15, height: 15)
                .foregroundColor(Color("blueDark"))
              Text(trip.location)
                .font(.custom("Jost", size: 12))
                .foregroundColor(Color("greenMedium"))
            }
            if trip.numberOfPhotos == 0 {
              Text("")
            } else {
              HStack(spacing: 4) {
                Image("Photo")
                  .resizable()
                  .renderingMode(.template)
                  .frame(width: 15, height: 15)
                  .foregroundColor(Color("blueDark"))
                Text("\(trip.numberOfPhotos) Photos")
                  .font(.custom("Jost", size: 12))
                  .foregroundColor(Color("greenMedium"))
              }
            }
            
            if trip.rating == "" {
              Text("")
            } else {
              HStack(spacing: 4) {
                Image("Star")
                  .resizable()
                  .renderingMode(.template)
                  .frame(width: 15, height: 15)
                  .foregroundColor(Color("blueDark"))
                Text(trip.rating)
                  .font(.custom("Jost", size: 12))
                  .foregroundColor(Color("greenMedium"))
              }
            }
          }
        }
        Spacer()
        
        Image("RightArrowAndCircle")
          .padding(.trailing, 20)
      }
      .padding(.bottom, 12)
      .padding(.leading, 20)
    }
    .background(Color("whiteEgg"))
    .clipShape(RoundedRectangle(cornerRadius: 12))
    .shadow(radius: 3, y: 1)
  }
  
    .padding(.horizontal, 16)
    .padding(.bottom, 20)
}
}
