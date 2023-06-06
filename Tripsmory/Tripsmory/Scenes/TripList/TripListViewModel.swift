//
//  TripListViewModel.swift
//  Tripsmory
//
//  Created by CatMeox on 28/3/2566 BE.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class TripListViewModel: ObservableObject {
  
  init(onTripSelected: @escaping (TripListItem) -> Void) {
    self.onTripSelected = onTripSelected
  }
  
  let onTripSelected: (TripListItem) -> Void
  
  @Published var trips: [TripListItem] = []
  @Published var isLoading = true
  
  @Published var isPresented = false
  
  
  
  func fetchTrips() {
    isLoading = true
    
    guard let userID = Auth.auth().currentUser?.uid else {
      isLoading = false
      return
    }
  
    let db = Firestore.firestore()
    db.collection("trips").whereField("userID", isEqualTo: userID).getDocuments() { (querySnapshot, err) in
      if let err = err {
        print("Error getting documents: \(err)")
      } else {
        var fetchedTrips: [TripListItem] = []
        
        let documents = querySnapshot!.documents
        let sortedDocument = documents.sorted { document1, document2 in
          let timestamp1 = (document1.data()["createdDate"] as? Timestamp)?.dateValue() ?? Date()
          let timestamp2 = (document2.data()["createdDate"] as? Timestamp)?.dateValue() ?? Date()
          return timestamp1 > timestamp2
        }
        
        for document in sortedDocument {
          let data = document.data()
          let coverImageURL = URL(string: (data["coverImageURL"] as? String) ?? "")
          let name = (data["name"] as? String) ?? ""
          let location = (data["location"] as? String) ?? ""
          let rating = (data["rating"] as? String) ?? ""
          let numberOfPhotos = (data["photoURLs"] as? [String] ?? []).count
          let trip = TripListItem(id: document.documentID, coverImageURL: coverImageURL, name: name, location: location, numberOfPhotos: numberOfPhotos, rating: rating)
          fetchedTrips.append(trip)
        }
        
        self.trips = fetchedTrips
      }
      
      self.isLoading = false
    }
  }
}


struct TripListItem: Identifiable {
  let id: String
  let coverImageURL: URL?
  let name: String
  let location: String
  let numberOfPhotos: Int
  let rating: String
}

