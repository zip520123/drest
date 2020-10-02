//
//  BookDetailViewController.swift
//  Drest
//
//  Created by zip520123 on 01/10/2020.
//  Copyright © 2020 zip520123. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
  let book: Book
  let service: ServiceType
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var idLabel: UILabel!
  @IBOutlet weak var bookImageView: UIImageView!
  
  init(_ book: Book, service: ServiceType) {
    self.book = book
    self.service = service
    super.init(nibName: "BookDetailViewController", bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  func setupUI() {
    view.backgroundColor = .white
    title = book.name
    nameLabel.text = book.name ?? "unknow"
    authorLabel.text = book.writer ?? "unknow"
    ratingLabel.text = book.rating ?? ""
    priceLabel.text = book.price ?? ""
    idLabel.text = book.id ?? ""
    
    service.requestImage(url: book.image ?? "") { [weak self] (data) in
      DispatchQueue.main.async {
        self?.bookImageView.image = UIImage(data: data)
      }
    }
  }
  
}
