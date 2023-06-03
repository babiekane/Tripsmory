//
//  AddTripViewModel.swift
//  Tripsmory
//
//  Created by CatMeox on 28/3/2566 BE.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth
import UIKit

class AddTripViewModel: ObservableObject {
  @Published var textName = ""
  @Published var textLocation = ""
  @Published var textDate = ""
  @Published var textRating = ""
  @Published var textCost = ""
  @Published var textStory = ""
  
  @Published var shouldPresentImagePicker = false
  @Published var shouldPresentActionScheet = false
  @Published var shouldPresentCamera = false
  
  @Published var imageTripsStored = [UIImage]()
  @Published var uploadedImageURLs = [URL]()
  
  func saveTrip() {
    guard let userID = Auth.auth().currentUser?.uid else {
      return
    }
    
    // Add a new document with a generated ID
    
    var uploadedImageURLStrings = [String]()
    for url in uploadedImageURLs {
      uploadedImageURLStrings.append(url.absoluteString)
    }
    
    var ref: DocumentReference? = nil
    let db = Firestore.firestore()
    let tripDictionary: [String: Any] = [
        "name": textName,
        "location": textLocation,
        "date": textDate,
        "rating": textRating,
        "cost": textCost,
        "story": textStory,
        "coverImageURL": uploadedImageURLs[0].absoluteString,
        "photoURLs": uploadedImageURLStrings,
        "userID": userID
    ]
    
    ref = db.collection("trips").addDocument(data: tripDictionary) { err in
        if let err = err {
            print("Error adding document: \(err)")
        } else {
            print("Document added with ID: \(ref!.documentID)")
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
      }
    }
  }
}

struct TextFieldItem {
  var name: String
  var location: String
  var date: String
  var rating: String
  var cost: String
  var story: String
  var photoURLs: [URL]
}


