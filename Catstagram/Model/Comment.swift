//
//  Comment.swift
//  Catstagram
//
//  Created by JISUNG LEE on 2023/06/29.
//

import FirebaseAuth

struct Comment {
    let uid: String
    let username: String
    let profileImageUrl: String
    let timestamp: Date
    let commentText: String
    
    init(dictionary: [String: Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.commentText = dictionary["comment"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Date ?? Date.now

    }
}
