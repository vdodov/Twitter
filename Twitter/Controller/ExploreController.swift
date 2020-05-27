//
//  ExploreController.swift
//  Twitter
//
//  Created by 차수연 on 2020/05/19.
//  Copyright © 2020 차수연. All rights reserved.
//

import UIKit

private let reuseIdentifier = "UserCell"

class ExploreController: UITableViewController {
  
  // MARK: - Properties
  
  private var users = [User]() {
    didSet { tableView.reloadData() }
  }
  
  private var filterUsers = [User]() {
    didSet { tableView.reloadData() }
  }
  
  private var isSearchMode: Bool {
    return searchController.isActive && !searchController.searchBar.text!.isEmpty
  }
  
  private let searchController = UISearchController(searchResultsController: nil)
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
    fetchUsers()
    configureSearchController()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.barStyle = .default
    navigationController?.navigationBar.isHidden = false
  }
  
  
  // MARK: - API
  func fetchUsers() {
    UserService.shared.fetchUsers { users in
      self.users = users
    }
  }
  
  // MARK: - Helper Functions
  
  func configureUI() {
    view.backgroundColor = .white
    
    navigationItem.title = "Explore"
    
    tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
    tableView.rowHeight = 60
    tableView.separatorStyle = .none
  }
  
  func configureSearchController() {
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.hidesNavigationBarDuringPresentation = false
    searchController.searchBar.placeholder = "Search for a user"
    navigationItem.searchController = searchController
    definesPresentationContext = false
  }
}

// MARK: - UITableViewDataSource/Delegate

extension ExploreController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return isSearchMode ? filterUsers.count : users.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
    let user = isSearchMode ? filterUsers[indexPath.row] : users[indexPath.row]
    cell.user = user
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let user = isSearchMode ? filterUsers[indexPath.row] : users[indexPath.row]
    let controller = ProfileController(user: user)
    navigationController?.pushViewController(controller, animated: true)
  }
}

// MARK: - UISearchResultsUpdating

extension ExploreController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    guard let searchText = searchController.searchBar.text?.lowercased() else { return }
    
    filterUsers = users.filter({ $0.username.contains(searchText) || $0.fullname.contains(searchText) })
  }
}

