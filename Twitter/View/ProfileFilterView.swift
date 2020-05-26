//
//  ProfileFilterView.swift
//  Twitter
//
//  Created by 차수연 on 2020/05/26.
//  Copyright © 2020 차수연. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ProfileFilterCell"

protocol ProfileFilterViewDelegate: class {
  func filterView(_ view: ProfileFilterView, didSelect indexPath: IndexPath)
}

class ProfileFilterView: UIView {
  
  // MARK: - Properties
  
  weak var delegate: ProfileFilterViewDelegate?
  
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.backgroundColor = .white
    cv.delegate = self
    cv.dataSource = self
    return cv
  }()
  
  // MARK: - LifeCycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    
    collectionView.register(ProfileFilterCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    
    let selectedIndexPath = IndexPath(row: 0, section: 0)
    collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .left)
    
    addSubview(collectionView)
    collectionView.addConstraintsToFillView(self)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - UICollectionViewDataSource

extension ProfileFilterView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return ProfileFilterOption.allCases.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProfileFilterCell
    
    let option = ProfileFilterOption(rawValue: indexPath.row)
    cell.option = option
    
    return cell
  }
}

// MARK: - UICollectionViewDelegate

extension ProfileFilterView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    delegate?.filterView(self, didSelect: indexPath)
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ProfileFilterView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let count = CGFloat(ProfileFilterOption.allCases.count)
    return CGSize(width: frame.width / count, height: frame.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}
