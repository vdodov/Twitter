//
//  ProfileFilterCell.swift
//  Twitter
//
//  Created by 차수연 on 2020/05/26.
//  Copyright © 2020 차수연. All rights reserved.
//

import UIKit

class ProfileFilterCell: UICollectionViewCell {
  
  // MARK: - Properties
  
  var option: ProfileFilterOption! {
    didSet { titleLabel.text = option.descrition }
  }
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.textColor = .lightGray
    label.font = UIFont.systemFont(ofSize: 14)
    label.text = "Test Filter"
    return label
  }()
  
  override var isSelected: Bool {
    didSet {
      titleLabel.font = isSelected ? UIFont.boldSystemFont(ofSize: 16) : UIFont.systemFont(ofSize: 14)
      titleLabel.textColor = isSelected ? .twitterBlue : .lightGray
    }
  }
  
  
  // MARK: - LifeCycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .white
    
    addSubview(titleLabel)
    titleLabel.center(inView: self)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
