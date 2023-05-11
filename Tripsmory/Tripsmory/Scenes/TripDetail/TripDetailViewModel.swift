//
//  TripDetailViewModel.swift
//  Tripsmory
//
//  Created by CatMeox on 28/3/2566 BE.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

struct TripDetail: Identifiable {
  let id: String
  let coverImageURL: URL?
  let name: String
  let location: String
  let numberOfPhotos: Int
  let rating: String
  let cost: String
  let date: String
  let story: String
  let photoURLs: [URL]
}

class TripDetailViewModel: ObservableObject {

  var tripID: String?
  @Published var detail: TripDetail?
  
  func showTripDetails() {
    guard let tripID = tripID else {
      return
    }
    
    let db = Firestore.firestore()
    db.collection("trips").document(tripID).getDocument { document, error in
      guard let document = document, let data = document.data() else {
        print(error?.localizedDescription)
        return
      }
      
      let coverImageURL = URL(string: (data["coverImageURL"] as? String) ?? "")
      let name = (data["name"] as? String) ?? ""
      let location = (data["location"] as? String) ?? ""
      let rating = (data["rating"] as? String) ?? ""
      let numberOfPhotos = (data["photoURLs"] as? [String] ?? []).count
      let cost = (data["cost"] as? String) ?? ""
      let date = (data["date"] as? String) ?? ""
      let story = (data["story"] as? String) ?? ""
      
      var photoURLs: [URL] = []
      if let photoURLStrings = data["photoURLs"] as? [String] {
        for photoURLString in photoURLStrings {
          if let url = URL(string: photoURLString) {
            photoURLs.append(url)
          }
        }
      }
      
      let detail = TripDetail(id: document.documentID, coverImageURL: coverImageURL, name: name, location: location, numberOfPhotos: numberOfPhotos, rating: rating, cost: cost, date: date, story: story, photoURLs: photoURLs)
      self.detail = detail
    }
  }
}
