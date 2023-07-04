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
  
  @State var isShowingCalendarView: Bool
  
  let onDelete: () -> Void
  
  var body: some View {
    GeometryReader { geometry in
      TextFieldEditView(viewModel: viewModel,
                        isShowingCalendarView: $isShowingCalendarView,
                        date: $viewModel.date,
                        onDelete: onDelete
      )
      
      BottomSheetCalendarView(isShowingCalendarView: $isShowingCalendarView, date: $viewModel.date)
    }
    .background(Color("appWhite"))
    .preferredColorScheme(.light)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .onChange(of: viewModel.placemark) { placemark in
      if let name = placemark?.name {
        viewModel.textLocation = name
      }
    }
    .fullScreenCover(isPresented: $viewModel.isSearchingLocation) {
      NavigationView {
        SearchLocationView(placemark: $viewModel.placemark, isSearchingLocation: $viewModel.isSearchingLocation)
      }
    }
  }
}

struct EditTripView_Previews: PreviewProvider {
  static var previews: some View {
    EditTripView(viewModel: EditTripViewModel(), isShowingCalendarView: false, onDelete: {})
  }
}

struct TextFieldEditView: View {
  @ObservedObject var viewModel: EditTripViewModel

  @State var selectedItems = [PhotosPickerItem]()
  @State var selectedPhotos = [UIImage]()
  
  @State var showingAlert = false
  
  @FocusState var isInputActive: Bool
  
  @Binding var isShowingCalendarView: Bool
  @Binding var date: Date
  
  @State private var isDatePickerShown = false
  
  let onDelete: () -> Void
  
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    GeometryReader { geometry in
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
                  
                  Button {
                    viewModel.isSearchingLocation = true
                  } label: {
                    HStack {
                      Text(viewModel.textLocation)
                        .padding(.leading, 16)
                        .foregroundColor(Color("appBlack"))
                        .frame(width: geometry.size.width - 32 - 30, height: 40, alignment: .leading)
                        .background((Color("greenLight").opacity(0.5)))
                        .clipShape(Capsule())
                      
                    Image(systemName: "location")
                      .foregroundColor(Color("greenMedium"))
                  }
                }
                }
                
                VStack(alignment: .leading, spacing: 0) {
                  Text("Date")
                    .font(.custom("Jost", size: 16))
                    .fontWeight(.medium)
                    .foregroundColor(Color("appBlack"))
                    .padding(.bottom, 4)
                  
                  Button {
                    withAnimation {
                      isShowingCalendarView.toggle()
                    }
                    self.isDatePickerShown = true
                    hideKeyboard()
                  } label: {
                    HStack {
                      Text("\(date.formatted(.dateTime.day().month().year()))")
                        .padding(.leading, 16)
                        .foregroundColor(Color("appBlack"))
                        .frame(width: geometry.size.width - 32 - 30, height: 40, alignment: .leading)
                        .background((Color("greenLight").opacity(0.5)))
                        .clipShape(Capsule())
                      
                      Spacer()
                      
                      Image(systemName: "calendar")
                        .foregroundColor(Color("greenMedium"))
                    }
                  }
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
                    .textFieldStyle(OvalTextViewStyle())
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
                  .frame(width: geometry.size.width / 2 - 32, height: 50)
                  .foregroundColor(Color("greenMedium"))
                  .background(Color("appWhite"))
                  .overlay(
                    Capsule().stroke(Color("greenMedium"), lineWidth: 4)
                  )
                  .clipShape(Capsule())
                  .padding(.vertical, 8)
              }
              
              if viewModel.isUploadingImages {
                Text("Update")
                  .font(.custom("Jost", size: 16))
                  .fontWeight(.medium)
                  .frame(width: geometry.size.width / 2 - 32, height: 50)
                  .foregroundColor(Color("appWhite"))
                  .background(Color("greenMedium").opacity(0.7))
                  .clipShape(Capsule())
                  .padding(.vertical, 8)
                
              } else {
                Button {
                  viewModel.updateTrip()
                  dismiss()
                } label: {
                  Text("Update")
                    .font(.custom("Jost", size: 16))
                    .fontWeight(.medium)
                    .frame(width: geometry.size.width / 2 - 32, height: 50)
                    .foregroundColor(Color("appWhite"))
                    .background(Color("greenMedium"))
                    .clipShape(Capsule())
                    .padding(.vertical, 8)
                }
              }
            }
            
            Button {
              showingAlert = true
            } label: {
              Text("Delete")
                .font(.custom("Jost", size: 16))
                .fontWeight(.medium)
                .frame(width: geometry.size.width - 48, height: 50)
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
                onDelete()
              }
            }
          }
        }
      }
      .frame(width: geometry.size.width, height: geometry.size.height)
      .background(Color("appWhite"))
      .onChange(of: selectedItems) { newItems in
        newItems.forEach { item in
          Task {
            guard let data = try? await item.loadTransferable(type: Data.self) else { return }
            guard let image = UIImage(data: data) else { return }
            viewModel.addImage(image)
          }
        }
        selectedItems = []
      }
    }
  }
}
