//
//  User.swift
//  Twitter
//
//  Created by 차수연 on 2020/05/23.
//  Copyright © 2020 차수연. All rights reserved.
//

import Foundation

struct User {
  let fullname: String
  let email: String
  let username: String
  var profileImageUrl: URL?
  let uid: String
  
  init(uid: String, dictionary: [String: Any]) {
    self.uid = uid
    
    self.fullname = dictionary["fullname"] as? String ?? ""
    self.email = dictionary["email"] as? String ?? ""
    self.username = dictionary["username"] as? String ?? ""
    
    if let profileImageUrlString = dictionary["profileImageUrl"] as? String {
      guard let url = URL(string: profileImageUrlString) else { return }
      self.profileImageUrl = url
    }
    
  }
}
