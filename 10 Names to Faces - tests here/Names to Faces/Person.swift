//
//  Person.swift
//  Names to Faces
//
//  Created by home on 5/14/18.
//  Copyright © 2018 LyfeBug. All rights reserved.
//

import UIKit

class Person: NSObject {
  var name: String
  var image: String
  
  init(name: String, image: String) {
    self.name = name
    self.image = image
  }
}
