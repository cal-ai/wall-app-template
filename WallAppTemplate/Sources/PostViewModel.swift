//
//  PostViewModel.swift
//  WallAppTemplate
//
//  Created by Wahab on 16/07/2024.
//

import Foundation
import SwiftUI
import FirebaseFirestore

class PostViewModel: ObservableObject {
    @Published var posts: [Post] = []
    private var postsListener: ListenerRegistration?
    let db = Firestore.firestore()

    init() {

        fetchPosts()
    }

    func fetchPosts() {
        postsListener = db.collection("posts")
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching posts: \(error!)")
                    return
                }

                self.posts = documents.map { (queryDocumentSnapshot) -> Post in
                    let data = queryDocumentSnapshot.data()
                    let id = queryDocumentSnapshot.documentID
                    let userId = data["userId"] as? String ?? ""
                    let content = data["content"] as? String ?? ""
                    let timestamp = data["timestamp"] as? TimeInterval ?? Date().timeIntervalSince1970
                    let username = data["user_name"] as? String ?? ""
                    let image = data["profile_image"] as? String ?? ""
                    return Post(id: id, userId: userId,userName: username, userProfileImage: image, content: content, timestamp: timestamp)
                }
            }
    }

  func addPost(userId: String, userName: String, userProfileImage: String, content: String) {
        let newPost = Post(id: UUID().uuidString, userId: userId,userName: userName, userProfileImage: userProfileImage, content: content, timestamp: Date().timeIntervalSince1970)
        db.collection("posts").document(newPost.id).setData(newPost.dict!)
    }

}
extension Date {
  func covertIntoTimeString() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "h:mm a"
    dateFormatter.timeZone = TimeZone.current
    let newDateString = dateFormatter.string(from: self)
    return newDateString
  }
}
