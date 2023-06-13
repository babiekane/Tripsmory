//
//  TripDetailView.swift
//  Tripsmory
//
//  Created by CatMeox on 28/3/2566 BE.
//

import SwiftUI

struct TripDetailView: View {
  
  @ObservedObject var viewModel: TripDetailViewModel
  @State var isShowingImages = false
  
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        if let detail = viewModel.detail {
          ShowDetailView(viewModel: viewModel,
                         detail: detail,
                         screenWidth: geometry.size.width,
                         screenHeight: geometry.size.height)
        }
      }
      .background(Color("appWhite"))
      .onAppear {
        viewModel.showTripDetails()
      }
      .overlay(
        
        // Image viewer
        ZStack {
          
          if viewModel.showImageViewer {
            
            Color.black
              .opacity(viewModel.bgOpacity)
              .ignoresSafeArea()
            
            ImageView()
          }
        }
      )
      // setting environment object
      .environmentObject(viewModel)
    }
    .background(Color("appWhite"))
    .preferredColorScheme(.light)
    .frame(width: .infinity, height: .infinity)
  }
}

struct TripDetailView_Previews: PreviewProvider {
  static var previews: some View {
    TripDetailView(viewModel: TripDetailViewModel())
  }
}

struct ShowDetailView: View {
  
  @ObservedObject var viewModel: TripDetailViewModel
  
  let detail: TripDetail
  
  let screenWidth: Double
  let screenHeight: Double
  
  @Environment(\.dismiss) var dismiss
  
  @State var isEditing = false
  
  var body: some View {
      VStack(alignment: .leading, spacing: 0) {
        ScrollView(showsIndicators: false) {
          ZStack(alignment: .top) {
            VStack {
              if let coverImage = detail.coverImageURL {
                AsyncImage(url: detail.coverImageURL) { image in
                  image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: screenWidth - 16, height: screenHeight / 2)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                } placeholder: {
                  ProgressView()
                    .tint(Color("greenDark"))
                    .frame(width: screenWidth - 16, height: screenHeight / 2)
                    .background(.gray.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
              } else {
                Image("NoImages")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .padding(20)
                  .frame(width: screenWidth - 16, height: screenHeight / 2)
                  .background(Color("Test1"))
                  .clipShape(RoundedRectangle(cornerRadius: 20))
              }
            }
            
            VStack(spacing: 0) {
              HStack {
                Button {
                  dismiss()
                } label: {
                  Image("Back")
                    .padding(16)
                    .background((Color("appWhite")).opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: 19))
                }
                
                Spacer()
                
                Button {
                  isEditing = true
                } label: {
                  Image("Edit")
                    .padding(16)
                    .background((Color("appWhite")).opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: 19))
                }
              }
              .padding(.horizontal, 16)
              
              Spacer()
            }
            .padding(.vertical, 8)
          }
          .padding(.vertical, 8)
          
          VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .firstTextBaseline) {
              Text(detail.name)
                .font(.custom("Jost", size: 24))
                .fontWeight(.semibold)
                .foregroundColor(Color("greenDark"))
              
              Spacer()
              
              if detail.rating == "" {
                Text("")
              }
              else {
                HStack(alignment: .center, spacing: 4) {
                  Image("Star.fill")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color("yellow"))
                  
                  Text(detail.rating)
                    .font(.custom("Jost", size: 16))
                    .fontWeight(.medium)
                    .foregroundColor(Color("greenDark"))
                }
              }
            }
            .padding(.horizontal, 26)
            .padding(.bottom, 8)
            
            ScrollView(.horizontal, showsIndicators: false) {
              HStack(alignment: .firstTextBaseline, spacing: 24) {
                HStack(spacing: 4) {
                  Image("Location")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color("blueDark"))
                  Text(detail.location)
                    .font(.custom("Jost", size: 14))
                    .foregroundColor(Color("greenMedium"))
                }
                
                if detail.date == "" {
                  Text("")
                } else {
                  HStack(spacing: 4) {
                    Image("Calendar")
                      .resizable()
                      .renderingMode(.template)
                      .frame(width: 20, height: 20)
                      .foregroundColor(Color("blueDark"))
                    Text(detail.date)
                      .font(.custom("Jost", size: 14))
                      .foregroundColor(Color("greenMedium"))
                  }
                }
                
                if detail.cost == "" {
                  Text("")
                } else {
                  HStack(spacing: 4) {
                    Image("Cost")
                      .resizable()
                      .renderingMode(.template)
                      .frame(width: 22, height: 22)
                      .foregroundColor(Color("blueDark"))
                    Text(detail.cost)
                      .font(.custom("Jost", size: 14))
                      .foregroundColor(Color("greenMedium"))
                  }
                }
              }
            }
            .padding(.horizontal, 26)
            .padding(.bottom, 20)
            
            if detail.story == "" {
              Text("")
            } else {
              Text("About this place")
                .font(.custom("Jost", size: 16))
                .fontWeight(.medium)
                .foregroundColor(Color("greenDark"))
                .padding(.leading, 26)
                .padding(.bottom, 4)
              
              Text("""
      "\(detail.story)"
      """)
              .padding(.horizontal, 36)
              .font(.custom("Jost", size: 14))
              .foregroundColor(Color("appBlack"))
              .padding(.bottom, 20)
            }
            
            if !detail.photoURLs.isEmpty {
              Text("Gallery")
                .font(.custom("Jost", size: 16))
                .fontWeight(.medium)
                .foregroundColor(Color("greenDark"))
                .padding(.leading, 26)
                .padding(.bottom, 4)
              
                HStack(spacing: 7) {
                  ForEach(0..<5) { index in
                    if index < detail.photoURLs.count {
                      let url = detail.photoURLs[index]
                      
                      if index < 4 {
                        Button {
                          withAnimation(.easeInOut) {
                            // For pages tab view automatic scrolling
                            viewModel.selectedImageURL = url
                            viewModel.showImageViewer.toggle()
                          }
                        } label: {
                          GalleryImageView(url: url,
                                           screenWidth: screenWidth,
                                           screenHeight: screenHeight)
                        }
                      } else {
                        Button {
                          withAnimation(.easeInOut) {
                            // For pages tab view automatic scrolling
                            viewModel.selectedImageURL = url
                            viewModel.showImageViewer.toggle()
                          }
                        } label: {
                          GalleryImageView(url: url,
                                           screenWidth: screenWidth,
                                           screenHeight: screenHeight)
                            .overlay {
                              let remainingImage = detail.photoURLs.count - 5
                              if remainingImage > 0 {
                                RoundedRectangle(cornerRadius: 20)
                                  .fill(Color.black.opacity(0.5))
                                
                                Text("+\(remainingImage)")
                                  .font(.custom("Jost", size: 16))
                                  .fontWeight(.bold)
                                  .foregroundColor(Color("appWhite"))
                              }
                            }
                        }
                      }
                    }
                  }
                }
              .padding(.horizontal, 26)
              .padding(.bottom, 8)
            } else {
              Text("")
            }
          }
          
          Spacer()
        }
        .fullScreenCover(isPresented: $isEditing) {
          if let editTripViewModel = viewModel.editTripViewModel {
            EditTripView(viewModel: editTripViewModel, onDelete: {
              DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                dismiss()
              }
            })
            .onDisappear {
              viewModel.showTripDetails()
            }
          } else {
            EmptyView()
          }
        }
      }
    
  }
  
  struct GalleryImageView: View {
    
    let url: URL
    
    let screenWidth: Double
    let screenHeight: Double
    
    var body: some View {
      AsyncImage(url: url) { image in
        image
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: screenWidth / 4.5 - 26 , height: screenWidth / 4.5 - 26)
          .clipShape(RoundedRectangle(cornerRadius: 20))
      } placeholder: {
        ProgressView()
          .tint(Color("greenDark"))
          .frame(width: screenWidth / 4.5 - 26 , height: screenWidth / 4.5 - 26)
          .background(.gray.opacity(0.3))
          .clipShape(RoundedRectangle(cornerRadius: 20))
      }
    }
  }
}
