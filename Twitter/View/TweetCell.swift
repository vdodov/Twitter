//
//  TweetCell.swift
//  Twitter
//
//  Created by 차수연 on 2020/05/24.
//  Copyright © 2020 차수연. All rights reserved.
//

import UIKit

class TweetCell: UICollectionViewCell {
  
  // MARK: - Properties
  
  var tweet: Tweet? {
    didSet { configure() }
  }
  
  private let profileImageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.setDimensions(width: 48, height: 48)
    iv.layer.cornerRadius = 48 / 2
    iv.backgroundColor = .twitterBlue
    return iv
  }()

  private let captionLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14)
    label.numberOfLines = 0
    label.text = "Some test caption"
    return label
  }()
  
  private lazy var commentButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "comment"), for: .normal)
    button.tintColor = .darkGray
    button.setDimensions(width: 20, height: 20)
    button.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
    return button
  }()
  
  private lazy var retweetButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "retweet"), for: .normal)
    button.tintColor = .darkGray
    button.setDimensions(width: 20, height: 20)
    button.addTarget(self, action: #selector(handleRetweetTapped), for: .touchUpInside)
    return button
  }()
  
  private lazy var likeButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "like"), for: .normal)
    button.tintColor = .darkGray
    button.setDimensions(width: 20, height: 20)
    button.addTarget(self, action: #selector(handleLikeTapped), for: .touchUpInside)
    return button
  }()
  
  private lazy var sharedButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "share"), for: .normal)
    button.tintColor = .darkGray
    button.setDimensions(width: 20, height: 20)
    button.addTarget(self, action: #selector(handleShareTapped), for: .touchUpInside)
    return button
  }()

  private let infoLabel = UILabel()
  
  // MARK: - LifeCycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    
    
    addSubview(profileImageView)
    profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)

    let stack = UIStackView(arrangedSubviews: [infoLabel, captionLabel])
    stack.axis = .vertical
    stack.distribution = .fillProportionally
    stack.spacing = 4

    contentView.addSubview(stack)
    stack.anchor(top: profileImageView.topAnchor, left: profileImageView.rightAnchor, right: rightAnchor, paddingLeft: 12, paddingRight: 12)

    infoLabel.font = UIFont.systemFont(ofSize: 14)
    infoLabel.text = "Eddie Broke @venom"
    
    let actionStack = UIStackView(arrangedSubviews: [commentButton, retweetButton, likeButton, sharedButton])
    actionStack.axis = .horizontal
    actionStack.spacing = 72
    
    addSubview(actionStack)
    actionStack.centerX(inView: self)
    actionStack.anchor(bottom: bottomAnchor, paddingBottom: 8)

    let underlineView = UIView()
    underlineView.backgroundColor = .systemGroupedBackground
    contentView.addSubview(underlineView)
    underlineView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 1)
  }
  
  
  // MARK: - Selectors
  @objc func handleCommentTapped() {
    print("DEBUG: handleCommentTapped")
  }
  
  @objc func handleRetweetTapped() {
    print("DEBUG: handleRetweetTapped")
  }
  
  @objc func handleLikeTapped() {
    print("DEBUG: handleLikeTapped")
  }
  
  @objc func handleShareTapped() {
    print("DEBUG: handleShareTapped")
  }
  
  // MARK: - Helper Functions
  
  func configure() {
    guard let tweet = tweet else { return }
    let viewModel = TweetViewModel(tweet: tweet)
    
    captionLabel.text = tweet.caption
    profileImageView.sd_setImage(with: viewModel.profileUrl, completed: nil)
    infoLabel.attributedText = viewModel.userInfoText
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
