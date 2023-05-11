//
//  GalleryView.swift
//  Tripsmory
//
//  Created by CatMeox on 26/4/2566 BE.
//

import SwiftUI

//struct GalleryView: View {
//
//  @State var isShowing = false
//
//  let id = "photo"
//  @Namespace var gallery
//
//  var body: some View {
//    VStack {
//      if isShowing {
//        PhotoView(id: id, namespace: gallery, action: {
//          withAnimation(.easeInOut) {
//            isShowing = false
//          }
//        })
//      } else {
//        Button {
//          withAnimation(.easeInOut) {
//            isShowing = true
//          }
//        } label: {
//          Image("Dazaifu")
//            .resizable()
//            .aspectRatio(contentMode: .fill)
//            .matchedGeometryEffect(id: id, in: gallery)
//            .frame(width: 70, height: 70)
//            .mask(
//              RoundedRectangle(cornerRadius: 20)
//              .matchedGeometryEffect(id: "\(id)-mask", in: gallery)
//              .frame(width: 70, height: 70)
//            )
//
//        }
//      }
//    }
//  }
//}

struct PhotoView: View {
  
  let id: URL
  let namespace: Namespace.ID
  let action: () -> Void
  
  var body: some View {
    VStack {
      Spacer()
      
      HStack {
        Spacer()
        
        Button {
          action()
        } label: {
          AsyncImage(url: id) { image in
            image
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: 350, height: 350)
          } placeholder: {
            Text("")
          }
          .matchedGeometryEffect(id: id, in: namespace)
          .mask(
            RoundedRectangle(cornerRadius: 20)
              .matchedGeometryEffect(id: "\(id)-mask", in: namespace)
              .frame(width: 350, height: 350)
          )
        }
        
        Spacer()
      }
      
      Spacer()
    }
    .background(Color("appBlack").opacity(0.7))
  }
}

//struct GalleryView_Previews: PreviewProvider {
//  static var previews: some View {
//    Group {
//      GalleryView()
//      //PhotoView()
//    }
//  }
//}
