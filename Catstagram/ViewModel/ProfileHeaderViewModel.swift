//
//  ProfileHeaderViewModel.swift
//  Catstagram
//
//  Created by JISUNG LEE on 2023/06/08.
//

import Foundation

struct ProfileHeaderViewModel {
    let user: User
    
    var fullname: String {
        return user.fullname
    }
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImageUrl)
    }

    init(user: User) {
        self.user = user
    }
}

