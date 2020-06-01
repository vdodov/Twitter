//
//  TweetController.swift
//  Twitter
//
//  Created by 차수연 on 2020/05/28.
//  Copyright © 2020 차수연. All rights reserved.
//

import UIKit

private let reuseIdentifier = "TweetCell"
private let headerIdentifier = "TweetHeader"

class TweetController: UICollectionViewController {
  
  // MARK: - Properties
  
  private let tweet: Tweet
  private var actionSheetLancher: ActionSheetLauncher
  private var replies = [Tweet]() {
    didSet { collectionView.reloadData() }
  }
  
  // MARK: - LifeCycle
  
  init(tweet: Tweet) {
    self.tweet = tweet
    self.actionSheetLancher = ActionSheetLauncher(user: tweet.user)
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureCollectionView()
    fetchReplies()
  }
  
  // MARK: - API
  
  func fetchReplies() {
    TweetService.shared.fetchReplies(forTweet: tweet) { replies in
      self.replies = replies
    }
  }
  
  // MARK: - Helper Functions
  
  func configureCollectionView() {
    collectionView.backgroundColor = .white
    
    collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    collectionView.register(TweetHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
  }
  
  fileprivate func showActionSheet(forUser user: User) {
    actionSheetLancher = ActionSheetLauncher(user: user)
    actionSheetLancher.delegate = self
    actionSheetLancher.show()
  }
  
}

// MARK: - UICollectionViewDataSource

extension TweetController {
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return replies.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
    cell.tweet = replies[indexPath.row]
    return cell
  }
}

// MARK: - UICollectionViewDelegate

extension TweetController {
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! TweetHeader
    header.tweet = tweet
    header.delegate = self
    return header
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TweetController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    
    let viewModel = TweetViewModel(tweet: tweet)
    let captionHeight = viewModel.size(forWidth: view.frame.width).height
    
    return CGSize(width: view.frame.width, height: captionHeight + 260)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 120)
  }
}

// MARK: - TweetHeaderDelegate

extension TweetController: TweetHeaderDelegate {
  func showActionSheet() {
    if tweet.user.isCurrentUser {
      showActionSheet(forUser: tweet.user)
    } else {
      UserService.shared.checkIfUserIsFollowed(uid: tweet.user.uid) { isFollow in
        var user = self.tweet.user
        user.isFollowed = isFollow
        self.showActionSheet(forUser: user)
      }
    }
  }
}

// MARK: - ActionSheetLauncherDelegate

extension TweetController: ActionSheetLauncherDelegate {
  func didSelect(option: ActionSheetOptions) {
    switch option {
    case .follow(let user):
      UserService.shared.followUser(uid: user.uid) { (err, ref) in
        print("DEBUG: Follow \(user.username)")
      }
    case .unfollow(let user):
      UserService.shared.unfollowUser(uid: user.uid) { (err, ref) in
        print("DEBUG: Unfollow \(user.username)")
      }
    case .report:
      print("DEBUG: Report tweet")
    case .delete:
      print("DEBUG: Delete twwet")
    }
  }
}
