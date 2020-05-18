//
//  FeedController.swift
//  Twitter
//
//  Created by 차수연 on 2020/05/19.
//  Copyright © 2020 차수연. All rights reserved.
//

import UIKit

class FeedController: UIViewController {
  
  // MARK: - Properties
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
  }
  
  // MARK: - Helper Functions
  
  func configureUI() {
    view.backgroundColor = .white
    
    let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
    imageView.contentMode = .scaleAspectFit
    
    navigationItem.titleView = imageView
    
  }
}
