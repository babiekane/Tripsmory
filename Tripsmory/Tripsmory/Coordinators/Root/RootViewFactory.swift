//
//  RootViewFactory.swift
//  Tripsmory
//
//  Created by yossa on 22/8/2566 BE.
//

import SwiftUI

protocol RootViewFactory {
  func makeRootStartFlow(onAuthSuccess: @escaping () -> Void) -> AnyView
  func makeRootMainFlow(onSignoutSuccess: @escaping () -> Void) -> AnyView
}
