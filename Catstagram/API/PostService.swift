//
//  PostService.swift
//  Catstagram
//
//  Created by JISUNG LEE on 2023/06/19.
//

import UIKit
import FirebaseAuth

struct PostService {
    static func uploadPost(caption: String, image: UIImage, complpetion: @escaping(FirestoreCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        ImageUploader.uploadImage(image: image) { imageUrl in
            let date = Date()
            let data = ["caption": caption,
                        "timestamp": date,
                        "likes": 0,
                        "imageUrl": imageUrl,
                        "ownerUid": uid] as [String: Any]
            
            COLLECTION_POSTS.addDocument(data: data, completion: complpetion)
        }
    }
    
    static func fetchPosts() {
        COLLECTION_POSTS.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            
            documents.forEach { doc in
                print("DEBUG: Doc data is \(doc.data())")
            }
        }
    }
}
