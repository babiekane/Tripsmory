//
//  EditTripView.swift
//  Tripsmory
//
//  Created by CatMeox on 28/3/2566 BE.
//

import SwiftUI

struct EditTripView: View {
  
  @ObservedObject var viewModel: EditTripViewModel
  
  
  var body: some View {
    GeometryReader { geometry in
      TextFieldEditView(textName: $viewModel.textName,
                        textLocation: $viewModel.textLocation,
                        textDate: $viewModel.textDate,
                        textRating: $viewModel.textRating,
                        textCost: $viewModel.textCost,
                        textStory: $viewModel.textStory,
                        viewModel: viewModel,
                        screenWidth: geometry.size.width,
                        screenHeight: geometry.size.height
      )
    }
  }
}

struct EditTripView_Previews: PreviewProvider {
  static var previews: some View {
    EditTripView(viewModel: EditTripViewModel())
  }
}

struct TextFieldEditView: View {
  @Binding var textName: String
  @Binding var textLocation: String
  @Binding var textDate: String
  @Binding var textRating: String
  @Binding var textCost: String
  @Binding var textStory: String
  
  @State var selectedImage: UIImage?
  @State var shouldPresentImagePicker = false
  @State var shouldPresentActionScheet = false
  @State var shouldPresentCamera = false
  
  @ObservedObject var viewModel: EditTripViewModel
  
  let screenWidth: Double
  let screenHeight: Double
  
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    ZStack {
      VStack(spacing: 0) {
        Text("Edit your trip")
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
            TextField("", text: $textName)
              .textFieldStyle(OvalTextFieldStyle())
              .disableAutocorrection(true)
            
          }
          
          VStack(alignment: .leading, spacing: 0) {
            Text("Location")
              .font(.custom("Jost", size: 16))
              .fontWeight(.medium)
              .foregroundColor(Color("appBlack"))
              .padding(.bottom, 4)
            TextField("", text: $textLocation)
              .textFieldStyle(OvalTextFieldStyle())
              .disableAutocorrection(true)
            
          }
          
          VStack(alignment: .leading, spacing: 0) {
            Text("Date")
              .font(.custom("Jost", size: 16))
              .fontWeight(.medium)
              .foregroundColor(Color("appBlack"))
              .padding(.bottom, 4)
            TextField("", text: $textDate)
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
              TextField("", text: $textRating)
                .textFieldStyle(OvalTextFieldStyle())
                .disableAutocorrection(true)
              
            }
            
            VStack(alignment: .leading, spacing: 0) {
              Text("Cost")
                .font(.custom("Jost", size: 16))
                .foregroundColor(Color("appBlack"))
                .fontWeight(.medium)
                .padding(.bottom, 4)
              TextField("", text: $textCost)
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
            TextField("", text: $textStory)
              .font(.custom("Jost", size: 16))
              .textFieldStyle(OvalTextFieldStyle())
              .disableAutocorrection(true)
            
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
                  ZStack {
                    RoundedRectangle(cornerRadius: 20)
                      .fill(Color("greenLight").opacity(0.5))
                      .frame(width: 80, height: 80)
                    Image("Camera")
                  }
                  
                  HStack {
                    ForEach(viewModel.uploadedImageURLs, id: \.self) { url in
                      AsyncImage(url: url) { image in
                        ZStack(alignment: .topTrailing) {
                          image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                          
                          Button {
                            viewModel.deleteImage(url: url)
                          } label: {
                            Image(systemName: "xmark")
                              .symbolVariant(.circle.fill)
                              .foregroundStyle(Color("greenDark"), Color("whiteEgg"))
                              .padding(6)
                          }
                          Spacer()
                        }
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
            }
            
            Spacer()
          }
          .onTapGesture {
            self.shouldPresentActionScheet = true
          }
        }
        Spacer()
      }
      .padding(.horizontal, 16)
      
      VStack {
        Spacer()
        HStack(spacing: 16) {
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
          
          Button {
            viewModel.updateTrip()
            dismiss()
          } label: {
            Text("Update")
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
    .frame(width: screenWidth, height: screenHeight)
    .background(Color("appWhite"))
    .sheet(isPresented: $shouldPresentImagePicker) {
      SUImagePickerView(sourceType: shouldPresentCamera ? .camera : .photoLibrary, image: $selectedImage, isPresented: $shouldPresentImagePicker)
    }
    .actionSheet(isPresented: $shouldPresentActionScheet) { () -> ActionSheet in
      ActionSheet(
        title: Text("Take a new photo or select a photo from library"),
        buttons: [
          ActionSheet.Button.default(Text("Camera"), action: {
            self.shouldPresentImagePicker = true
            self.shouldPresentCamera = true
          }),
          ActionSheet.Button.default(Text("Photo Library"), action: {
            self.shouldPresentImagePicker = true
            self.shouldPresentCamera = false
          }),
          ActionSheet.Button.cancel()
        ]
      )
    }
    .onChange(of: selectedImage) { newValue in
      if let image = newValue {
        viewModel.addImage(image)
      }
    }
  }
}

