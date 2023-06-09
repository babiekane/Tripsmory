//
//  LocationManager.swift
//  Tripsmory
//
//  Created by CatMeox on 3/7/2566 BE.
//

import SwiftUI
import CoreLocation
import MapKit
// MARK: Combine Framework to watch TextField Change
import Combine

class LocationManager: NSObject, ObservableObject, MKMapViewDelegate, CLLocationManagerDelegate {
  
  // MARK: Properties
  @Published var mapView: MKMapView = .init()
  @Published var manager: CLLocationManager = .init()
  
  // MARK: Search Bar Text
  @Published var searchText: String = ""
  var cancellable: AnyCancellable?
  @Published var fetchedPlaces: [CLPlacemark]?
  
  // MARK: User location
  @Published var userLocation: CLLocation?
  
  // MARK: Final location
  @Published var pickedLocation: CLLocation?
  @Published var pickedPlaceMark: CLPlacemark?
  
  override init() {
    super.init()
    //MARK: Setting Delegate
    manager.delegate = self
    mapView.delegate = self
    
    // MARK: Requesting Location Access
    manager.requestWhenInUseAuthorization()
    
    // MARK: Search TextField Watching
    cancellable = $searchText
      .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
      .removeDuplicates()
      .sink(receiveValue: { value in
        if value != "" {
          self.fetchPlaces(value: value)
        } else {
          self.fetchedPlaces = nil
        }
      })
  }
  
  func fetchPlaces(value: String) {
    // MARK: Fetching places using MKLocalSearch & Asyc/Await
    Task {
      do {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = value.lowercased()
        
        let response = try await MKLocalSearch(request: request).start()
        // We can also use mainactor to publish change in Main Thread
        await MainActor.run(body: {
          self.fetchedPlaces = response.mapItems.compactMap({ item -> CLPlacemark? in
            return item.placemark
          })
        })
      } catch {
        // HANDLE ERROR
      }
    }
  }
  
  func locationManager(_ manger: CLLocationManager, didFailWithError error: Error) {
    // HANDLE ERROR
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let currentLocation = locations.last else {
      return
    }
    self.userLocation = currentLocation
  }
  
  // MARK: Location Authorization
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    switch manager.authorizationStatus {
    case .authorizedAlways: manager.requestLocation()
    case .authorizedWhenInUse: manager.requestLocation()
    case .denied: handleLocationError()
    case .notDetermined: manager.requestWhenInUseAuthorization()
    default: ()
    }
  }
  
  func handleLocationError() {
    // HANDLE ERROR
  }
  
  // MARK: Add draggable pin to MapView
  func addDraggablePin(coordinate: CLLocationCoordinate2D) {
    let annotation = MKPointAnnotation()
    annotation.coordinate = coordinate
    annotation.title = "Your location"
    
    mapView.addAnnotation(annotation)
  }
  
  // MARK: Enabling Dragging
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    let marker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "LOCATIONPIN")
    marker.isDraggable = true
    marker.canShowCallout = false
    
    return marker
  }
  
  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
    guard let newLocation = view.annotation?.coordinate else {
      return
    }
    self.pickedLocation = .init(latitude: newLocation.latitude, longitude: newLocation.longitude)
    updatePlacemark(location: .init(latitude: newLocation.latitude, longitude: newLocation.longitude))
  }
  
  func updatePlacemark(location: CLLocation) {
    Task {
      do {
        guard let place = try await reverseLocationCoordinates(location: location) else {
          return
        }
        await MainActor.run(body: {
          self.pickedPlaceMark = place
        })
      } catch {
        // HANDLE ERROR
      }
    }
  }
  
  // MARK: Displaying new location data
  func reverseLocationCoordinates(location: CLLocation) async throws -> CLPlacemark? {
    let place = try await CLGeocoder().reverseGeocodeLocation(location).first
    return place
  }
}
