//
//  ActionSheetViewModel.swift
//  Twitter
//
//  Created by 차수연 on 2020/05/29.
//  Copyright © 2020 차수연. All rights reserved.
//

import Foundation

struct ActionSheetViewModel {
  
  private let user: User
  
  var options: [ActionSheetOptions] {
    var result = [ActionSheetOptions]()
    
    if user.isCurrentUser {
      result.append(.delete)
    } else {
      let followOption: ActionSheetOptions = user.isFollowed ? .unfollow(user) : .follow(user)
      result.append(followOption)
    }
    
    result.append(.report)
    
    return result
  }
  
  init(user: User) {
    self.user = user
  }
}

enum ActionSheetOptions {
  case follow(User)
  case unfollow(User)
  case report
  case delete
  
  var description: String {
    switch self {
    case .follow(let user): return "Follow @\(user.username)"
    case .unfollow(let user): return "Unfollow @\(user.username)"
    case .report: return "Report Tweet"
    case .delete: return "Delete Tweet"
    }
  }
}
