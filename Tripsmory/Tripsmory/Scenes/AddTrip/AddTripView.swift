//
//  AddTripView.swift
//  Tripsmory
//
//  Created by CatMeox on 28/3/2566 BE.
//

import SwiftUI

struct AddTripView: View {
  
  @ObservedObject var viewModel: AddTripViewModel
  
  
  var body: some View {
    GeometryReader { geometry in
      TextFieldView(textName: $viewModel.textName,
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

struct AddTripView_Previews: PreviewProvider {
  static var previews: some View {
    AddTripView(viewModel: AddTripViewModel())
  }
}

struct TextFieldView: View {
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
  
  @ObservedObject var viewModel: AddTripViewModel
  
  let screenWidth: Double
  let screenHeight: Double
  
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
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
          .onTapGesture { self.shouldPresentActionScheet = true }
        }
        Spacer()
      }
      .padding(.horizontal, 16)
      
      VStack {
        Spacer()
        Button {
          viewModel.saveTrip()
          dismiss()
        } label: {
          Text("Save to your memory")
            .font(.custom("Jost", size: 16))
            .fontWeight(.medium)
            .frame(width: screenWidth - 32, height: 50)
            .foregroundColor(Color("appWhite"))
            .background(Color("greenMedium"))
            .clipShape(RoundedRectangle(cornerRadius: 40))
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
        }
      }
    }
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
//        viewModel.imageTripsStored.append(image)
        viewModel.addImage(image)
      }
    }
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
