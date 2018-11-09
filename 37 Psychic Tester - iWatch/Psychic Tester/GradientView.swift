//
//  GradientView.swift
//  Psychic Tester
//
//  Created by home on 6/29/18.
//  Copyright © 2018 LyfeBug. All rights reserved.
//

import UIKit

@IBDesignable class GradientView: UIView {
  @IBInspectable var topColor: UIColor = UIColor.white
  @IBInspectable var bottomColor: UIColor = UIColor.black
  
  
  
  override class var layerClass: AnyClass {
    return CAGradientLayer.self
  }
  
  override func layoutSubviews() {
    (layer as! CAGradientLayer).colors = [topColor.cgColor, bottomColor.cgColor]
  }
}
