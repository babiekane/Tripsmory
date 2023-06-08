//
//  EditTripView.swift
//  Tripsmory
//
//  Created by CatMeox on 28/3/2566 BE.
//

import SwiftUI
import PhotosUI

struct EditTripView: View {
  
  @ObservedObject var viewModel: EditTripViewModel
  
  var body: some View {
    GeometryReader { geometry in
      TextFieldEditView(viewModel: viewModel,
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
  @ObservedObject var viewModel: EditTripViewModel

  @State var selectedItems = [PhotosPickerItem]()
  @State var selectedPhotos = [UIImage]()
  
  @State var showingAlert = false
  
  @FocusState var isInputActive: Bool
  
  
  let screenWidth: Double
  let screenHeight: Double
  
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    NavigationStack {
      VStack(spacing: 8) {
        ScrollView(showsIndicators: false) {
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
                      PhotosPicker(selection: $selectedItems,
                                   matching: .images) {
                        
                        ZStack {
                          RoundedRectangle(cornerRadius: 20)
                            .fill(Color("greenLight").opacity(0.5))
                            .frame(width: 80, height: 80)
                          Image("Camera")
                        }
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
              }
            }
          }
        }
        .padding(.horizontal, 16)
        
        VStack(spacing: 0) {
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
          
          Button {
            showingAlert = true
          } label: {
            Text("Delete")
              .font(.custom("Jost", size: 16))
              .fontWeight(.medium)
              .frame(width: screenWidth - 48, height: 50)
              .foregroundColor(Color("appWhite"))
              .background(Color("Red"))
              .clipShape(Capsule())
              .padding(.bottom, 8)
          }
          .alert("Are you sure to delete this trip?", isPresented: $showingAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
              viewModel.deleteTrip()
              dismiss()
            }
          }
        }
      }
    }
    .frame(width: screenWidth, height: screenHeight)
    .background(Color("appWhite"))
    .onChange(of: selectedItems) { newItems in
         newItems.forEach { item in
             Task {
                 guard let data = try? await item.loadTransferable(type: Data.self) else { return }
                 guard let image = UIImage(data: data) else { return }
               viewModel.addImage(image)
             }
         }
    }
  }
}
