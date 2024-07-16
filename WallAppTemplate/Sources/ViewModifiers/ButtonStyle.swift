//
//  ButtonStyle.swift
//  WallAppTemplate
//
//  Created by Wahab on 17/07/2024.
//

import Foundation
import SwiftUI

struct PostButtonStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.title3)
      .foregroundColor(.white)
      .fontWeight(.medium)
      .padding()
      .frame(height: 40)
      .background(.main)
      .cornerRadius(8)
  }
}
extension View {
    func postButtonStyle() -> some View {
        modifier(PostButtonStyle())
    }
}
