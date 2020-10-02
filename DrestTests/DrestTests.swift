//
//  DrestTests.swift
//  DrestTests
//
//  Created by zip520123 on 01/10/2020.
//  Copyright © 2020 zip520123. All rights reserved.
//

import XCTest
@testable import Drest

class DrestTests: XCTestCase {

  func test_BookDecode() throws {
    let data = try readString(from: "booklist.json").data(using: .utf8)!
    
    let model = try! JSONDecoder().decode(BookData.self, from: data).books
    
    XCTAssert(model.count == 12)
    XCTAssert(model[0].id == "1")
    XCTAssert(model[0].name == "P.S. I love You")
    XCTAssert(model[0].writer == "Cecelia Ahern")
    XCTAssert(model[0].price == "Rs. 299")
    XCTAssert(model[0].rating == "4.5")
    XCTAssert(model[0].image == "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1422881430l/20698530.jpg")

    
  }
  
  func test_MockStringApi() throws {
    let service = try mockService(with: "booklist.json")
    
    let requset = XCTestExpectation()
    
    service.requestBooklist { (model) in
      XCTAssert(model.count == 12)
      XCTAssert(model[0].id == "1")
      XCTAssert(model[0].name == "P.S. I love You")
      XCTAssert(model[0].writer == "Cecelia Ahern")
      XCTAssert(model[0].price == "Rs. 299")
      XCTAssert(model[0].rating == "4.5")
      XCTAssert(model[0].image == "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1422881430l/20698530.jpg")
      requset.fulfill()
    }
    
    wait(for: [requset], timeout: 0.1)
    
  }
  
  func test_RealApiEndpoint() throws {
    let service = Service()
    
    let requset = XCTestExpectation()
    
    service.requestBooklist { (model) in
      XCTAssert(model.count == 12)
      XCTAssert(model[0].id == "1")
      XCTAssert(model[0].name == "P.S. I love You")
      XCTAssert(model[0].writer == "Cecelia Ahern")
      XCTAssert(model[0].price == "Rs. 299")
      XCTAssert(model[0].rating == "4.5")
      XCTAssert(model[0].image == "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1422881430l/20698530.jpg")
      requset.fulfill()
    }
    
    wait(for: [requset], timeout: 0.5)
    
  }
  
  func test_apiCallAtBackgroundThread() {
    let service = Service()
    let requset = XCTestExpectation()
    service.requestBooklist { (model) in
      XCTAssert(Thread.isMainThread == false)
      requset.fulfill()
    }
    wait(for: [requset], timeout: 0.5)
    
  }
  
  func test_loadImageCache() {
    let cache = NSCache<NSString, NSData>()
    
    let service = Service(cache: cache)
    let imageString = "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1422881430l/20698530.jpg"

    XCTAssert(cache.object(forKey: NSString(string: imageString)) == nil)
    
    let request = XCTestExpectation()
    service.requestImage(url: imageString) { (data) in
      request.fulfill()
      XCTAssert(cache.object(forKey: NSString(string: imageString)) != nil)
      
    }
    wait(for: [request], timeout: 1)
  }

}
extension XCTestCase {
  func mockService(with file: String) throws -> MockService {
    return MockService(testString: try readString(from: file))
  }
  
  func readString(from file: String) throws -> String {
    //Json fails reading multiline string. Instead read json from file https://bugs.swift.org/browse/SR-6457
    let bundle = Bundle(for: type(of: self))
    let path = bundle.url(forResource: file, withExtension: nil)!
    let data = try Data(contentsOf: path)
    return String(data: data, encoding: .utf8)!
  }
}
