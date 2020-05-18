//
//  MainTabController.swift
//  Twitter
//
//  Created by 차수연 on 2020/05/19.
//  Copyright © 2020 차수연. All rights reserved.
//

import UIKit

class MainTabController: UITabBarController {
  
  // MARK: - Properties
  
  let actionButton: UIButton = {
    let button = UIButton(type: .system)
    button.tintColor = .white
    button.backgroundColor = .twitterBlue
    button.setImage(UIImage(named: "new_tweet"), for: .normal)
    button.addTarget(self, action: #selector(actionbuttonTapped), for: .touchUpInside)
    return button
  }()
  
  // MARK: - LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureViewControllers()
    configureUI()
  }
  
  // MARK: - Selectors
  
  @objc func actionbuttonTapped() {
    print(123)
  }
  
  // MARK: - Helper Functions
  
  func configureUI() {
    view.addSubview(actionButton)
    actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
    
    actionButton.layer.cornerRadius = 56 / 2
    
  }
  
  func configureViewControllers() {
    
    let feed = FeedController()
    let nav1 = templeateNavigationController(image:  UIImage(named: "home_unselected"), rootController: feed)
    
    let explore  = ExploreController()
    let nav2 = templeateNavigationController(image: UIImage(named: "search_unselected"), rootController: explore)
    
    let notifications = NotificationsController()
    let nav3 = templeateNavigationController(image: UIImage(named: "like_unselected"), rootController: notifications)
    
    let conversations = ConversationsController()
    let nav4 = templeateNavigationController(image: UIImage(named: "ic_mail_outline_white_2x-1"), rootController: conversations)
    
    viewControllers = [nav1, nav2, nav3, nav4]
  }
  
  func templeateNavigationController(image: UIImage?, rootController: UIViewController) -> UINavigationController {
    
    let nav = UINavigationController(rootViewController: rootController)
    nav.tabBarItem.image = image
    nav.navigationBar.barTintColor = .white
    
    return nav
  }
  
}