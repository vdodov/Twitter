//
//  UserService.swift
//  Twitter
//
//  Created by 차수연 on 2020/05/23.
//  Copyright © 2020 차수연. All rights reserved.
//

import Firebase

struct UserService {
  static let shared = UserService()
  
  //현재 로그인 되어있는 유저정보 가져오기.
  func fetchUser(completion: @escaping(User) -> Void) {
    guard  let uid = Auth.auth().currentUser?.uid else { return }
    
    REF_USERS.child(uid).observeSingleEvent(of: .value) { (snapshot) in
      guard let dictionary = snapshot.value as? [String: Any] else { return }
      
      let user = User(uid: uid, dictionary: dictionary)
      completion(user)
    }
  }
}
