//
//  TweetViewModel.swift
//  Twitter
//
//  Created by 차수연 on 2020/05/25.
//  Copyright © 2020 차수연. All rights reserved.
//

import UIKit

struct TweetViewModel {
  let tweet: Tweet
  let user: User
  
  var profileUrl: URL? {
    return tweet.user.profileImageUrl
  }
  
  var timestamp: String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
    formatter.maximumUnitCount = 1
    formatter.unitsStyle = .abbreviated
    let now = Date()
    return formatter.string(from: tweet.timestamp, to: now) ?? "2m"
  }
  
  var userInfoText: NSAttributedString {
    let title = NSMutableAttributedString(string: user.fullname, attributes: [.font : UIFont.boldSystemFont(ofSize: 14)])
    
    title.append(NSAttributedString(string: " @\(user.username)", attributes: [.font : UIFont.systemFont(ofSize: 14),
                                                                               .foregroundColor : UIColor.lightGray]))
    
    title.append(NSAttributedString(string: " ・ \(timestamp)", attributes: [.font : UIFont.systemFont(ofSize: 14),
                                                                               .foregroundColor : UIColor.lightGray]))
    
    return title
  }
  
  init(tweet: Tweet) {
    self.tweet = tweet
    self.user = tweet.user
  }
}
