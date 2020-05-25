//
//  FeedController.swift
//  Twitter
//
//  Created by 차수연 on 2020/05/19.
//  Copyright © 2020 차수연. All rights reserved.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "TweetCell"

class FeedController: UICollectionViewController {
  
  // MARK: - Properties
  
  var user: User? {
    didSet {
      configureLeftBarButton()
    }
  }
  
  private var tweets = [Tweet]() {
    didSet { collectionView.reloadData() }
  }
  
  // MARK: - LifeCycle
  
  override init(collectionViewLayout layout: UICollectionViewLayout) {
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
    fetchTweet()
  }
  
  // MARK: - API
  func fetchTweet() {
    TweetService.shared.fetchTweets { tweets in
      self.tweets = tweets
    }
  }
  
  // MARK: - Helper Functions
  
  func configureUI() {
    view.backgroundColor = .white
    
    collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    collectionView.backgroundColor = .white
    
    let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
    imageView.contentMode = .scaleAspectFit
    imageView.setDimensions(width: 44, height: 44)
    navigationItem.titleView = imageView
  }
  
  func configureLeftBarButton() {
    guard let user = user else { return }
    
    let profileImageView = UIImageView()
    profileImageView.setDimensions(width: 32, height: 32)
    profileImageView.layer.cornerRadius = 32 / 2
    profileImageView.layer.masksToBounds = true
    
    profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
  }
}

// MARK: - UICollectionViewDelegate/DataSource

extension FeedController {
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return tweets.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
    cell.tweet = tweets[indexPath.row]
    return cell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FeedController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 120)
  }
}
