//
//  ImageView.swift
//  Tripsmory
//
//  Created by CatMeox on 16/5/2566 BE.
//

import SwiftUI

struct ImageView: View {
  @EnvironmentObject var viewModel: TripDetailViewModel
  @GestureState var draggingOffset: CGSize = .zero
  
  
  var body: some View {
    
    ZStack {
  
      ScrollView(.init()) {
        TabView(selection: $viewModel.selectedImageURL) {
          
          ForEach(viewModel.detail!.photoURLs, id: \.self) { url in
            
            AsyncImage(url: url) { image in
              image
              .resizable()
              .aspectRatio(contentMode: .fit)
              .tag(url)
              // ทำไรอะ งง
              .scaleEffect(viewModel.selectedImageURL == url ? (viewModel.imageScale > 1 ? viewModel.imageScale : 1) : 1)
              // Moving only image for smooth animation
              .offset(y: viewModel.imageViewerOffset.height)
              .gesture(
                
                MagnificationGesture().onChanged({ (value) in
                  viewModel.imageScale = value
                }).onEnded({ (_) in
                  withAnimation(.spring()) {
                    viewModel.imageScale = 1
                  }
                })
                
                //Double to zoom
                  .simultaneously(with: TapGesture(count: 2).onEnded({
                    withAnimation {
                      viewModel.imageScale = viewModel.imageScale > 1 ? 1 : 4
                    }
                  }))
                
              )
            } placeholder : {
              
            }
          }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .overlay(
          
          // close button
          Button {
            withAnimation(.default) {
              // Removing all
              viewModel.showImageViewer.toggle()
            }
          } label: {
            Image(systemName: "xmark")
              .foregroundColor(.white)
              .padding()
              .background(Color.white.opacity(0.35))
              .clipShape(Circle())
          }
            .padding(10)
            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
            .opacity(viewModel.bgOpacity)
          , alignment: .topTrailing
        )
      }
      .ignoresSafeArea()
    
    }
    .gesture(DragGesture().updating($draggingOffset, body: { (value, outValue, _) in
      outValue = value.translation
      viewModel.onChange(value: draggingOffset)
      
    }).onEnded(viewModel.onEnd(value:)))
    .transition(.move(edge: .bottom))
  }
}

struct ImageView_Previews: PreviewProvider {
  static var previews: some View {
    ImageView()
  }
}
