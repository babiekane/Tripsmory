//
//  EditTripViewModel.swift
//  Tripsmory
//
//  Created by CatMeox on 28/3/2566 BE.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage
import UIKit
import CoreLocation

class EditTripViewModel: ObservableObject {
  
  init(detail: TripDetail, onUpdated: @escaping () -> Void, onDeleted: @escaping () -> Void, onCancel: @escaping () -> Void) {
    id = detail.id
    textName = detail.name
    textLocation = detail.location
    date = detail.date
    textRating = detail.rating
    textCost = detail.cost
    textStory = detail.story
    uploadedImageURLs = detail.photoURLs
    
    self.onUpdated = onUpdated
    self.onDeleted = onDeleted
    self.onCancel = onCancel
  }
  
  let onUpdated: () -> Void
  let onDeleted: () -> Void
  let onCancel: () -> Void
  
  @Published var textName = ""
  @Published var textLocation = ""
  @Published var placemark: CLPlacemark?
  var textDate: String? {
    date?.formatted(.dateTime.day().month().year())
  }
  @Published var date: Date?
  @Published var textRating = ""
  @Published var textCost = ""
  @Published var textStory = ""
  @Published var uploadedImageURLs = [URL]()
  
  @Published var shouldPresentImagePicker = false
  @Published var shouldPresentActionScheet = false
  @Published var shouldPresentCamera = false
  
  @Published var isUploadingImages = false
  @Published var isSearchingLocation = false
  
  var id: String?
  
  func cancel() {
    onCancel()
  }
  
  func updateTrip() {
    guard let id = id else {
      return
    }
    
    // convert URL to String
    var uploadedImageURLStrings = [String]()
    for url in uploadedImageURLs {
      uploadedImageURLStrings.append(url.absoluteString)
    }
    
    // create data dictionary of trip
    var tripDictionary: [String: Any] = [
      "name": textName,
      "location": textLocation,
      "date": date,
      "rating": textRating,
      "cost": textCost,
      "story": textStory,
//      "coverImageURL": uploadedImageURLs[0].absoluteString,
      "photoURLs": uploadedImageURLStrings
    ]
    
    if !uploadedImageURLs.isEmpty {
      tripDictionary.updateValue(uploadedImageURLs[0].absoluteString, forKey: "coverImageURL")
    }
    
    // update trip
    let db = Firestore.firestore()
    db.collection("trips").document(id).updateData(tripDictionary) { [weak self] err in
      if let err = err {
        print("Error updating document: \(err)")
      } else {
        print("Document successfully updated")
        self?.onUpdated()
      }
    }
  }
  
  func addImage(_ image: UIImage) {
    //1 upload image to Firebase
    // Data in memory
    let data = image.jpegData(compressionQuality: 0.8)!
    
    // Create a reference to the file you want to upload
    let storage = Storage.storage()
    let storageRef = storage.reference()
    let photoRef = storageRef.child("\(UUID().uuidString).jpg")
    isUploadingImages = true
    
    // Upload the file to the path "images/rivers.jpg"
    _ = photoRef.putData(data, metadata: nil) { (metadata, error) in
      guard error == nil else {
        print(error?.localizedDescription as Any)
        // An error occurred!
        return
      }
      
      //2 get uploaded image URL
      // You can also access to download URL after upload.
      photoRef.downloadURL { (url, error) in
        guard let downloadURL = url else {
          print(error?.localizedDescription as Any)
          // An error occurred!
          return
        }
        
        print(downloadURL)
        //3 store image URL in uploadedImageURLs
        self.uploadedImageURLs.append(downloadURL)
        self.isUploadingImages = false
      }
    }
  }
  
  func deleteImage(url: URL) {
    guard let index = uploadedImageURLs.firstIndex(of: url) else {
      return
    }
    
    uploadedImageURLs.remove(at: index)
  }
  
  func deleteTrip() {
    guard let id = id else {
      return
    }
    
    let db = Firestore.firestore()
    db.collection("trips").document(id).delete() { [weak self] err in
      if let err = err {
        print("Error removing document: \(err)")
      } else {
        print("Document successfully removed!")
        self?.onDeleted()
      }
    }
  }
}


struct TextFieldEditItem {
  var name: String
  var location: String
  var date: String
  var rating: String
  var cost: String
  var story: String
  var photoURLs: [URL]
}


