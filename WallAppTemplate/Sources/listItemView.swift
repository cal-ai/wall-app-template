//
//  listItemView.swift
//  WallAppTemplate
//
//  Created by Wahab on 16/07/2024.
//

import SwiftUI

struct listItemView: View {
  var post: Post
  var body: some View {

    HStack(alignment:.top) {
      AsyncImage(url: URL(string: post.userProfileImage)) { image in
          image.resizable()
      } placeholder: {
        Image("profile_icon")
          .resizable()
      }
      .frame(width: 50, height: 50)
      .clipShape(.circle)
      VStack(alignment:.leading) {
        Text(post.userName)
          .font(Font.system(size: 18).bold())
        Text(post.content)
          .font(Font.system(size: 16))
      }
      Spacer()
      VStack() {
        Text(Date(timeIntervalSince1970: post.timestamp).covertIntoTimeString())
          .font(Font.system(size: 16).italic())
      }
    }

  }
}


