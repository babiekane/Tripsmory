//
//  AddTripView.swift
//  Tripsmory
//
//  Created by CatMeox on 28/3/2566 BE.
//

import SwiftUI
import PhotosUI

struct AddTripView: View {
  
  @ObservedObject var viewModel: AddTripViewModel
  
  
  var body: some View {
    GeometryReader { geometry in
      TextFieldView(viewModel: viewModel,
                    screenWidth: geometry.size.width,
                    screenHeight: geometry.size.height
      )
    }
  }
}

struct AddTripView_Previews: PreviewProvider {
  static var previews: some View {
    AddTripView(viewModel: AddTripViewModel())
  }
}

struct TextFieldView: View {
  @ObservedObject var viewModel: AddTripViewModel
  
//  @State var selectedImage: UIImage?
//  @State var shouldPresentImagePicker = false
//  @State var shouldPresentActionScheet = false
//  @State var shouldPresentCamera = false
  @State var selectedItems = [PhotosPickerItem]()
  @State var selectedPhotos = [UIImage]()
  
  @FocusState var isInputActive: Bool
  
  
  let screenWidth: Double
  let screenHeight: Double
  
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    NavigationStack {
      ZStack {
        VStack(spacing: 0) {
          Text("Tell me about your wonderful place")
            .font(.custom("Jost", size: 24))
            .fontWeight(.semibold)
            .foregroundColor(Color("greenDark"))
            .padding(.vertical, 20)
          VStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 0) {
              Text("Name")
                .font(.custom("Jost", size: 16))
                .fontWeight(.medium)
                .foregroundColor(Color("appBlack"))
                .padding(.bottom, 4)
              TextField("", text: $viewModel.textName)
                .textFieldStyle(OvalTextFieldStyle())
                .disableAutocorrection(true)
              
            }
            
            VStack(alignment: .leading, spacing: 0) {
              Text("Location")
                .font(.custom("Jost", size: 16))
                .fontWeight(.medium)
                .foregroundColor(Color("appBlack"))
                .padding(.bottom, 4)
              TextField("", text: $viewModel.textLocation)
                .textFieldStyle(OvalTextFieldStyle())
                .disableAutocorrection(true)
              
            }
            
            VStack(alignment: .leading, spacing: 0) {
              Text("Date")
                .font(.custom("Jost", size: 16))
                .fontWeight(.medium)
                .foregroundColor(Color("appBlack"))
                .padding(.bottom, 4)
              TextField("", text: $viewModel.textDate)
                .textFieldStyle(OvalTextFieldStyle())
                .disableAutocorrection(true)
              
            }
            
            HStack {
              VStack(alignment: .leading, spacing: 0) {
                Text("Rating")
                  .font(.custom("Jost", size: 16))
                  .fontWeight(.medium)
                  .foregroundColor(Color("appBlack"))
                  .padding(.bottom, 4)
                TextField("", text: $viewModel.textRating)
                  .textFieldStyle(OvalTextFieldStyle())
                  .disableAutocorrection(true)
                
              }
              
              VStack(alignment: .leading, spacing: 0) {
                Text("Cost")
                  .font(.custom("Jost", size: 16))
                  .foregroundColor(Color("appBlack"))
                  .fontWeight(.medium)
                  .padding(.bottom, 4)
                TextField("", text: $viewModel.textCost)
                  .textFieldStyle(OvalTextFieldStyle())
                  .disableAutocorrection(true)
                
              }
            }
            
            VStack(alignment: .leading, spacing: 0) {
              Text("Best parts of this place...")
                .font(.custom("Jost", size: 16))
                .fontWeight(.medium)
                .foregroundColor(Color("appBlack"))
                .padding(.bottom, 4)
              
              TextField("", text: $viewModel.textStory, axis: .vertical)
                .lineLimit(6, reservesSpace: true)
                .font(.custom("Jost", size: 16))
                .textFieldStyle(OvalTextFieldStyle())
                .disableAutocorrection(true)
                .focused($isInputActive)
                .toolbar {
                  ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                      isInputActive = false
                    }
                  }
                }
            }
            
            HStack {
              VStack(alignment: .leading, spacing: 0) {
                Text("Photo")
                  .font(.custom("Jost", size: 16))
                  .fontWeight(.medium)
                  .foregroundColor(Color("appBlack"))
                  .padding(.bottom, 4)
                
                ScrollView(.horizontal, showsIndicators: false) {
                  HStack {
//                      RoundedRectangle(cornerRadius: 20)
//                        .fill(Color("greenLight").opacity(0.5))
//                        .frame(width: 80, height: 80)
//                      Image("Camera")
                      
                      PhotosPicker(selection: $selectedItems,
                                               matching: .images) {
                        
                        ZStack {
                          RoundedRectangle(cornerRadius: 20)
                            .fill(Color("greenLight").opacity(0.5))
                            .frame(width: 80, height: 80)
                          Image("Camera")
                        
                      }
                    }
                    
                    ForEach(viewModel.uploadedImageURLs, id: \.self) { url in
                      AsyncImage(url: url) { image in
                        image
                          .resizable()
                          .aspectRatio(contentMode: .fill)
                          .frame(width: 80, height: 80)
                          .clipShape(RoundedRectangle(cornerRadius: 20))
                      } placeholder: {
                        ProgressView()
                          .tint(Color("greenDark"))
                          .frame(width: 80, height: 80)
                          .background(.gray.opacity(0.3))
                          .clipShape(RoundedRectangle(cornerRadius: 20))
                      }
                    }
                  }
                }
              }
              
              Spacer()
            }
//            .onTapGesture { self.shouldPresentActionScheet = true }
          }
          Spacer()
        }
        .padding(.horizontal, 16)
        
        VStack {
          
          Spacer()
          
          HStack {
            Button {
              dismiss()
            } label: {
              Text("Cancel")
                .font(.custom("Jost", size: 16))
                .fontWeight(.medium)
                .frame(width: screenWidth / 2 - 32, height: 50)
                .foregroundColor(Color("greenMedium"))
                .background(Color("appWhite"))
                .overlay(
                  Capsule().stroke(Color("greenMedium"), lineWidth: 4)
                )
                .clipShape(Capsule())
                .padding(.vertical, 8)
            }
            
            if viewModel.isUploadingImages {
              Text("Save to your memory")
                .font(.custom("Jost", size: 16))
                .fontWeight(.medium)
                .frame(width: screenWidth / 2 - 32, height: 50)
                .foregroundColor(Color("appWhite"))
                .background(Color("greenMedium").opacity(0.7))
                .clipShape(Capsule())
                .padding(.vertical, 8)
            } else {
              Button {
                viewModel.saveTrip()
                dismiss()
              } label: {
                Text("Save to your memory")
                  .font(.custom("Jost", size: 16))
                  .fontWeight(.medium)
                  .frame(width: screenWidth / 2 - 32, height: 50)
                  .foregroundColor(Color("appWhite"))
                  .background(Color("greenMedium"))
                  .clipShape(Capsule())
                  .padding(.vertical, 8)
              }
            }
          }
        }
      }
    }
    .background(Color("appWhite"))
    .preferredColorScheme(.light)
    .frame(width: .infinity, height: .infinity)
    .onChange(of: selectedItems) { newItems in
         newItems.forEach { item in
             Task {
                 guard let data = try? await item.loadTransferable(type: Data.self) else { return }
                 guard let image = UIImage(data: data) else { return }
               viewModel.addImage(image)
             }
         }
     }
//    .sheet(isPresented: $shouldPresentImagePicker) {
//      SUImagePickerView(sourceType: shouldPresentCamera ? .camera : .photoLibrary, image: $selectedImage, isPresented: $shouldPresentImagePicker)
//    }
//    .actionSheet(isPresented: $shouldPresentActionScheet) { () -> ActionSheet in
//      ActionSheet(
//        title: Text("Take a new photo or select a photo from library"),
//        buttons: [
//          ActionSheet.Button.default(Text("Camera"), action: {
//            self.shouldPresentImagePicker = true
//            self.shouldPresentCamera = true
//          }),
//          ActionSheet.Button.default(Text("Photo Library"), action: {
//            self.shouldPresentImagePicker = true
//            self.shouldPresentCamera = false
//          }),
//          ActionSheet.Button.cancel()
//        ]
//      )
//    }
//    .onChange(of: selectedImage) { newValue in
//      if let image = newValue {
//        viewModel.addImage(image)
//      }
    }
  }



struct OvalTextFieldStyle: TextFieldStyle {
  func _body(configuration: TextField<Self._Label>) -> some View {
    configuration
      .padding(10)
      .background(Color("greenLight").opacity(0.5))
      .foregroundColor(Color("appBlack"))
      .cornerRadius(20)
  }
}
