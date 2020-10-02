//
//  Service.swift
//  Drest
//
//  Created by zip520123 on 01/10/2020.
//  Copyright © 2020 zip520123. All rights reserved.
//

import Foundation

protocol ServiceType {
  func requestBooklist(callBack: @escaping (_ booklist: [Book]) -> Void)
  func requestImage(url: String, callBack: @escaping (Data)-> Void)
}

struct Service: ServiceType {
  private let cache: NSCache<NSString, NSData>
  
  init(cache: NSCache<NSString, NSData> = NSCache<NSString, NSData>()) {
    self.cache = cache
  }
  
  func requestImage(url: String, callBack: @escaping (Data)-> Void) {
    let cacheID = NSString(string: url)
    
    if let cachedData = cache.object(forKey: cacheID) {
      callBack((cachedData as Data))
    }else{
      if let url = URL(string: url) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        var request = URLRequest(url: url)
        request.cachePolicy = .returnCacheDataElseLoad
        request.httpMethod = "get"
        session.dataTask(with: request) { (data, response, error) in
          if let data = data {
            self.cache.setObject(data as NSData, forKey: cacheID)
            callBack(data)
          }
        }.resume()
      } else {
        callBack(Data())
      }
    }
  }
  
  func requestBooklist(callBack: @escaping ([Book]) -> Void) {
    let urlString = "https://run.mocky.io/v3/5e839124-bf06-423b-ba92-7ba68831d876"
    
    guard let url = URL(string: urlString) else { fatalError("url parse error") }
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      guard let data = data, let books = try? JSONDecoder().decode(BookData.self, from: data).books else {
        #if DEBUG
        fatalError("task error")
        #else
        callBack([]);
        #endif
        return
      }
      callBack(books)
    }
    
    task.resume()
    
  }
  
}

struct MockService: ServiceType {
  var testString : String = ""
  
  func requestBooklist(callBack: @escaping ([Book]) -> Void) {
    let data = testString.data(using: .utf8)!
    let books = try! JSONDecoder().decode(BookData.self, from: data).books
    callBack(books)
  }
  
  func requestImage(url: String, callBack: @escaping (Data)-> Void) {
    
  }
  
}


