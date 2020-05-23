//
//  TweetService.swift
//  Twitter
//
//  Created by 차수연 on 2020/05/23.
//  Copyright © 2020 차수연. All rights reserved.
//

import Firebase

struct TweetService {
  static let shared = TweetService()
  
  func uploadTweet(caption: String, completion: @escaping(Error?, DatabaseReference) -> Void) {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    let values = ["uid": uid,
                  "timestamp": Int(NSDate().timeIntervalSince1970),
                  "likes": 0,
                  "retweets": 0,
                  "caption": caption] as [String: Any]
    
    REF_TWEETS.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
  }
}
