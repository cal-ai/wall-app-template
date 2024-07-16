import Foundation
import SwiftUI

struct MainScreenView: View {
  @State private var postTxt = ""
  @StateObject var postModel = PostViewModel()
  @EnvironmentObject var auth: AuthModel
  var body: some View {
    NavigationStack {
      VStack {
        Divider()
        TextField("Write something here...", text: $postTxt)
          .postTextFieldStyle()
        HStack(alignment:.top) {
          Button(action: addNewPost, label: {
            Text("Add to the wall")
              .postButtonStyle()
          })
          .padding([.leading, .top, .bottom], 6)
          Spacer()
        }
        Divider()
        VStack() {
          List(postModel.posts) { post in
            listItemView(post: post)
          }
        }
        .listStyle(.plain)
        .ignoresSafeArea()
      }
      .navigationTitle("Wall")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar() {
        ToolbarItem(placement: .topBarLeading) {
          Button("Log Out") {
            auth.signOut()
          }
        }
      }
    }
  }
  func addNewPost() {
    if !postTxt.trimmingCharacters(in: .whitespaces).isEmpty {
      let url = auth.user?.photoURL?.absoluteString
      postModel.addPost(userId: auth.user!.uid,userName: (auth.user?.displayName)!,userProfileImage: url!, content: postTxt)
      UIApplication.shared.endEditing()
      postTxt = ""
    }

  }
}
#Preview {
  NavigationStack {
    MainScreenView()
  }
}
