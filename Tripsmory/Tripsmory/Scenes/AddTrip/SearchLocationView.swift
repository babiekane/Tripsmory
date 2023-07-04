//
//  SearchLocationView.swift
//  Tripsmory
//
//  Created by CatMeox on 3/7/2566 BE.
//

import SwiftUI
import MapKit

struct SearchLocationView : View {
  @StateObject var locationManager: LocationManager = .init()
  //MARK: Navigation tag to push view to mapView
  @State var navigationTag: String?
  @Environment(\.dismiss) var dismiss
  @Binding var placemark: CLPlacemark?
  @Binding var isSearchingLocation: Bool
  
  var body: some View {
    VStack {
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
          
          Text("Search location")
            .font(.custom("Jost", size: 24))
            .bold()
            .foregroundColor(Color("greenDark"))
          
          Spacer()
        }
      }
      
      HStack(spacing: 8) {
        Image(systemName: "magnifyingglass")
          .foregroundColor(Color("greenMedium").opacity(0.5))
        
        TextField("Find location here", text: $locationManager.searchText)
          .font(.custom("Jost", size: 16))
      }
      .padding(.vertical, 12)
      .padding(.horizontal)
      .background{
        RoundedRectangle(cornerRadius: 30)
          .strokeBorder(Color("greenMedium").opacity(0.5))
        }

      if let places = locationManager.fetchedPlaces, !places.isEmpty {
        List {
          ForEach(places, id: \.self) { place in
            Button {
              if let coordinate = place.location?.coordinate {
                locationManager.pickedLocation = .init(latitude: coordinate.latitude, longitude: coordinate.longitude)
                locationManager.mapView.region = .init(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                locationManager.addDraggablePin(coordinate: coordinate)
                locationManager.updatePlacemark(location: .init(latitude: coordinate.latitude, longitude: coordinate.longitude))
              }
              
              // MARK: Navigating to MapView
              navigationTag = "MAPVIEW"
            } label: {
              HStack(spacing: 12) {
                Image(systemName: "mappin.circle.fill")
                  .font(.title2)
                  .foregroundColor(Color("greenMedium").opacity(0.7))
                
                VStack(alignment: .leading, spacing: 6) {
                  Text(place.name ?? "")
                    .font(.custom("Jost", size: 16))
                    .fontWeight(.semibold)
                    .foregroundColor(Color("appBlack"))
                  
                  Text(place.locality ?? "")
                    .font(.custom("Jost", size: 12))
                    .foregroundColor(.gray)
                }
              }
            }
          }
        }
        .listStyle(.plain)
      } else {
        // MARK: Live Location Button
        Button {
          // MARK: Setting map region
          if let coordinate = locationManager.userLocation?.coordinate {
            locationManager.mapView.region = .init(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            locationManager.addDraggablePin(coordinate: coordinate)
            locationManager.updatePlacemark(location: .init(latitude: coordinate.latitude, longitude: coordinate.longitude))
            
            // MARK: Navigating to MapView
            navigationTag = "MAPVIEW"
          }
        } label: {
          Label {
            Text("Use Current Location")
              .font(.custom("Jost", size: 16))
          } icon: {
            Image(systemName: "location")
          }
          .foregroundColor(Color("greenMedium"))
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .center)
      }
    }
    .padding()
    .frame(maxHeight: .infinity, alignment: .top)
    .background {
      NavigationLink(tag: "MAPVIEW", selection: $navigationTag) {
        MapViewSelection(placemark: $placemark, isSearchingLocation: $isSearchingLocation)
          .environmentObject(locationManager)
          .navigationBarHidden(true)
      } label: {}
      .labelsHidden()
    }
  }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
      SearchLocationView(placemark: .constant(nil), isSearchingLocation: .constant(false))
    }
}

// MARK: MapView Live Selection
struct MapViewSelection: View {
  @EnvironmentObject var locationManager: LocationManager
  @Environment(\.dismiss) var dismiss
  
  @Binding var placemark: CLPlacemark?
  @Binding var isSearchingLocation: Bool
  
  var body: some View {
    ZStack {
      MapViewHelper()
        .environmentObject(locationManager)
        .ignoresSafeArea()
      
      Button {
        dismiss()
      } label: {
        Image(systemName: "chevron.left")
          .font(.title2)
          .fontWeight(.semibold)
          .foregroundColor(Color("greenDark"))
      }
      .padding()
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
      
      // MARK: Displaying data
      if let place = locationManager.pickedPlaceMark {
        VStack(spacing: 10) {
          Text("Your Location")
            .font(.custom("Jost", size: 20))
            .fontWeight(.bold)
            .foregroundColor(Color("greenDark"))
          
          HStack(spacing: 15) {
            Image(systemName: "mappin.circle.fill")
              .font(.title2)
              .foregroundColor(Color("greenMedium").opacity(0.7))
            
            VStack(alignment: .leading, spacing: 6) {
              Text(place.name ?? "")
                .font(.custom("Jost", size: 16))
                .fontWeight(.semibold)
                .foregroundColor(Color("appBlack"))
              
              Text(place.locality ?? "")
                .font(.custom("Jost", size: 12))
                .foregroundColor(.gray)
            }
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.vertical, 10)
          
          Button {
            placemark = place
            isSearchingLocation = false
          } label: {
            Text("Confirm location")
              .font(.custom("Jost", size: 16))
              .fontWeight(.semibold)
              .frame(maxWidth: .infinity)
              .padding(.vertical, 12)
              .background {
                RoundedRectangle(cornerRadius: 30)
                  .fill(Color("greenMedium"))
              }
              .foregroundColor(Color("appWhite"))
          }
        }
        .padding()
        .background {
          RoundedRectangle(cornerRadius: 20)
            .fill(Color("appWhite"))
            .ignoresSafeArea()
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
      }
    }
    .onDisappear {
      locationManager.pickedLocation = nil
      locationManager.pickedPlaceMark = nil
      
      locationManager.mapView.removeAnnotations(locationManager.mapView.annotations)
    }
  }
}

// MARK: UIKit MapView
struct MapViewHelper: UIViewRepresentable {
  @EnvironmentObject var locationManager: LocationManager
  func makeUIView(context: Context) -> MKMapView {
    return locationManager.mapView
  }
  
  func updateUIView(_ uiView: MKMapView, context: Context) {
    
  }
}
