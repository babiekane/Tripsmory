//
//  AddTripView.swift
//  Tripsmory
//
//  Created by CatMeox on 28/3/2566 BE.
//

import SwiftUI
import PhotosUI
import MapKit

struct AddTripView: View {
  
  @ObservedObject var viewModel: AddTripViewModel
  
  @State var isShowingCalendarView: Bool
  @State var pickerDate: Date?
  
  var body: some View {
    GeometryReader { geo in
      TextFieldView(viewModel: viewModel,
                    isShowingCalendarView: $isShowingCalendarView
      )
      
      BottomSheetCalendarView(isShowingCalendarView: $isShowingCalendarView, date: $pickerDate)
    }
    .onChange(of: pickerDate) { newValue in
      viewModel.date = newValue
    }
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

struct AddTripView_Previews: PreviewProvider {
  static var previews: some View {
    AddTripView(viewModel: AddTripViewModel(), isShowingCalendarView: false)
  }
}

struct TextFieldView: View {
  @ObservedObject var viewModel: AddTripViewModel
  
  @State var selectedItems = [PhotosPickerItem]()
  @State var selectedPhotos = [UIImage]()
  
  @FocusState var isInputActive: Bool
  
  @State var showAlert: Bool = false
  
  @Binding var isShowingCalendarView: Bool
  
  @State private var isDatePickerShown = false
  
  @Environment(\.dismiss) var dismiss

  
  var body: some View {
    GeometryReader { geo in
      NavigationStack {
        ScrollView(.vertical, showsIndicators: false) {
          VStack(spacing: 0) {
            Text("Add your memory")
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
                        .frame(width: geo.size.width - 32 - 30, height: 40, alignment: .leading)
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
                    Text("\(viewModel.date?.formatted(.dateTime.day().month().year()) ?? "")")
                      .padding(.leading, 16)
                      .foregroundColor(Color("appBlack"))
                      .frame(width: geo.size.width - 32 - 30, height: 40, alignment: .leading)
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
                    .padding(.bottom, -4)
                  
                  Text("Limit 5 photos per batch")
                    .font(.custom("Jost", size: 12))
                    .foregroundColor(.gray)
                    .padding(.bottom, 8)
                  
                  ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                      PhotosPicker(selection: $selectedItems,
                                   maxSelectionCount: 5,
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
                
                Spacer()
              }
            }
          }
        }
        .padding(.horizontal, 16)
        
        VStack {
          HStack {
            Button {
              dismiss()
            } label: {
              Text("Cancel")
                .font(.custom("Jost", size: 16))
                .fontWeight(.medium)
                .frame(width: geo.size.width / 2 - 32, height: 50)
                .foregroundColor(Color("greenMedium"))
                .background(Color("appWhite"))
                .overlay(
                  Capsule().stroke(Color("greenMedium"), lineWidth: 4)
                )
                .clipShape(Capsule())
                .padding(.vertical, 8)
            }
            
            if viewModel.isUploadingImages {
              Text("Save")
                .font(.custom("Jost", size: 16))
                .fontWeight(.medium)
                .frame(width: geo.size.width / 2 - 32, height: 50)
                .foregroundColor(Color("appWhite"))
                .background(Color("greenMedium").opacity(0.7))
                .clipShape(Capsule())
                .padding(.vertical, 8)
            } else {
              Button {
                if viewModel.textName.isEmpty || viewModel.textLocation.isEmpty {
                  showAlert = true
                } else {
                  viewModel.saveTrip()
                  dismiss()
                }
              } label: {
                Text("Save")
                  .font(.custom("Jost", size: 16))
                  .fontWeight(.medium)
                  .frame(width: geo.size.width / 2 - 32, height: 50)
                  .foregroundColor(Color("appWhite"))
                  .background(Color("greenMedium"))
                  .clipShape(Capsule())
                  .padding(.vertical, 8)
              }
              .alert(isPresented: $showAlert) {
                Alert(
                  title: Text("Missing information"),
                  message: Text("Please fill name and location."),
                  dismissButton: .default(Text("OK"))
                )
              }
            }
          }
        }
      }
      .background(Color("appWhite"))
      .preferredColorScheme(.light)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
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



struct OvalTextFieldStyle: TextFieldStyle {
  func _body(configuration: TextField<Self._Label>) -> some View {
    configuration
      .padding(10)
      .padding(.leading, 6)
      .frame(height: 40)
      .background(Color("greenLight").opacity(0.5))
      .foregroundColor(Color("appBlack"))
      .cornerRadius(20)
  }
}

struct OvalTextViewStyle: TextFieldStyle {
  func _body(configuration: TextField<Self._Label>) -> some View {
    configuration
      .padding(10)
      .padding(.leading, 6)
      .background(Color("greenLight").opacity(0.5))
      .foregroundColor(Color("appBlack"))
      .cornerRadius(20)
  }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
