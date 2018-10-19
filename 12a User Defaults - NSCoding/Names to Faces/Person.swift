//
//  Person.swift
//  Names to Faces
//
//  Created by home on 5/14/18.
//  Copyright © 2018 LyfeBug. All rights reserved.
//

import UIKit

// Person made a class (not struct) so it could be used with NSCoding | Codable works with both classes/structs
class Person: NSObject, NSCoding {
  var name: String
  var image: String
  
  init(name: String, image: String) {
    self.name = name
    self.image = image
  }
  
  required init(coder aDecoder: NSCoder) {
    name = aDecoder.decodeObject(forKey: "name") as! String
    image = aDecoder.decodeObject(forKey: "image") as! String
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: "name")
    aCoder.encode(image, forKey: "image")
  }
}
