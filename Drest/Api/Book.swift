//
//  Book.swift
//  Drest
//
//  Created by zip520123 on 01/10/2020.
//  Copyright © 2020 zip520123. All rights reserved.
//

import Foundation
struct BookData: Decodable {
  let books: [Book]
  private enum CodingKeys: String, CodingKey {
    case books = "bookdata"
  }
}

struct Book: Decodable {
  var id: String?
  var name: String?
  var writer: String?
  var price: String?
  var rating: String?
  var image: String?
  
  private enum CodingKeys: String, CodingKey {
    case id = "bookid"
    case name = "bookName"
    case writer = "bookWriter"
    case price = "bookPrice"
    case rating = "bookRating"
    case image = "bookImage"
  }
  
}
