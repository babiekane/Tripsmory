//
//  TripDetailViewModel.swift
//  Tripsmory
//
//  Created by CatMeox on 28/3/2566 BE.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import UIKit
import SwiftUI

struct TripDetail: Identifiable {
  let id: String
  let coverImageURL: URL?
  let name: String
  let location: String
  let numberOfPhotos: Int
  let rating: String
  let cost: String
  let date: Date?
  let story: String
  let photoURLs: [URL]
  
  var textDate: String? {
    date?.formatted(.dateTime.day().month().year())
  }
}

class TripDetailViewModel: ObservableObject {
  
  init(tripID: String) {
    self.tripID = tripID
  }

  let tripID: String
  @Published var detail: TripDetail?
  var editTripViewModel: EditTripViewModel?
  
  func showTripDetails() {
    let db = Firestore.firestore()
    db.collection("trips").document(tripID).getDocument { document, error in
      guard let document = document, let data = document.data() else {
        print(error?.localizedDescription as Any)
        return
      }
      
      let coverImageURL = URL(string: (data["coverImageURL"] as? String) ?? "")
      let name = (data["name"] as? String) ?? ""
      let location = (data["location"] as? String) ?? ""
      let rating = (data["rating"] as? String) ?? ""
      let numberOfPhotos = (data["photoURLs"] as? [String] ?? []).count
      let cost = (data["cost"] as? String) ?? ""
//      let date = (data["date"] as? Timestamp)?.dateValue().formatted(.dateTime.day().month().year()) ?? ""
      let date = (data["date"] as? Timestamp)?.dateValue()
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
  
  @Published var showImageViewer = false
  @Published var selectedImageURL: URL = URL(string: "http://some-url.com")!
  
  @Published var imageViewerOffset: CGSize = .zero
  
  //BG opacity
  @Published var bgOpacity: Double = 1
  
  // Scaling
  @Published var imageScale: CGFloat = 1
  
  func onChange(value: CGSize) {
    imageViewerOffset = value
    
    // Calculating opacity
    let halgHeight = UIScreen.main.bounds.height / 2
    
    let progress = imageViewerOffset.height / halgHeight
    
    withAnimation(.default) {
      bgOpacity = Double(1 - (progress < 0 ? -progress : progress))
    }
  }
  
  func onEnd(value: DragGesture.Value) {
    withAnimation(.easeInOut) {
      
      var translation = value.translation.height
      
      if translation < 0 {
        translation = -translation
      }
      
      if translation < 250 {
        imageViewerOffset = .zero
        bgOpacity = 1
      } else {
        showImageViewer.toggle()
        imageViewerOffset = .zero
        bgOpacity = 1
      }
    }
  }
}



