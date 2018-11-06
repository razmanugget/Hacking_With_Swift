//
//  ViewController.swift
//  What's that whistle
//
//  Created by home on 6/16/18.
//  Copyright © 2018 LyfeBug. All rights reserved.
//

import UIKit

// MARK: - Enums \ Extensions



class ViewController: UIViewController {
  // MARK: - Variables
  
  
  // MARK: - IBActions
  
  
  // MARK: - Functions
  @objc func addWhistle() {
    let vc = RecordWhistleViewController()
    
    navigationController?.pushViewController(vc, animated: true)
  }
  
  
  
  // MARK: - Override Functions
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "What's that Whistle?"
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWhistle))
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: nil, action: nil)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

