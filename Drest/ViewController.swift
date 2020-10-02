//
//  ViewController.swift
//  Drest
//
//  Created by zip520123 on 01/10/2020.
//  Copyright © 2020 zip520123. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  let tableView = UITableView()
  let refreshControl = UIRefreshControl()
  let service: ServiceType
  var books = [Book]()
  
  init(service: ServiceType) {
    self.service = service
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    service.requestBooklist(callBack: booklistHandler)
  }

  func setupUI() {
    view.backgroundColor = .white
    title = "Book list"
    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.delegate = self
    tableView.dataSource = self
    tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    tableView.refreshControl = refreshControl
    tableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    
    tableView.register(UINib(nibName: "BookTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
  }
  
  func booklistHandler(_ books: [Book]) {
    DispatchQueue.main.async { [weak self] in
      self?.books = books
      self?.tableView.reloadData()
    }
  }
  
  @objc func handleRefreshControl() {
    refreshControl.endRefreshing()
    service.requestBooklist(callBack: booklistHandler)
  }
  
  // MARK: - tableView datasource
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return books.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BookTableViewCell
    
    cell.titleLabel.text = books[indexPath.row].name ?? "unknow"
    cell.authorLabel.text = books[indexPath.row].writer ?? "unknow"
    service.requestImage(url: books[indexPath.row].image ?? "") { (data) in
      DispatchQueue.main.async {
        cell.coverImageView.image = UIImage(data: data)
      }
    }
    
    return cell
  }
  
  // MARK: tableView delegate
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    defer {
      tableView.deselectRow(at: indexPath, animated: true)
    }
    
    let detailVC = BookDetailViewController(books[indexPath.row], service: service)
    navigationController?.pushViewController(detailVC, animated: true)
    
  }

}

