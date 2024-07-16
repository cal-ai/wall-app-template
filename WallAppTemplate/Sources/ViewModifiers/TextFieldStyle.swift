//
//  TextFieldStyle.swift
//  WallAppTemplate
//
//  Created by Wahab on 17/07/2024.
//

import Foundation
import SwiftUI

struct PostTextFieldStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(Font.system(size: 24))
      .multilineTextAlignment(.leading)
      .padding(EdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6))
  }
}

extension View {
  func postTextFieldStyle() -> some View {
    modifier(PostTextFieldStyle())
  }
}
