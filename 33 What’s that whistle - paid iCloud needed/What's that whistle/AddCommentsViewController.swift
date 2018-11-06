//
//  AddCommentsViewController.swift
//  What's that whistle
//
//  Created by home on 6/17/18.
//  Copyright © 2018 LyfeBug. All rights reserved.
//

import UIKit

class AddCommentsViewController: UIViewController, UITextViewDelegate {
  var genre: String!
  
  var comments: UITextView!
  let placeholder = "If you have any additional comments that might help identify your tune, enter them here."
  
  
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.text == placeholder {
      textView.text = ""
    }
  }
  
  
  @objc func submitTapped() {
    let vc = SubmitViewController()
    vc.genre = genre
    
    if comments.text == placeholder {
      vc.comments = ""
    } else {
      vc.comments = comments.text
    }
    
    navigationController?.pushViewController(vc, animated: true)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    comments = UITextView()
    comments.translatesAutoresizingMaskIntoConstraints = false
    comments.delegate = self
    comments.font = UIFont.preferredFont(forTextStyle: .body)
    view.addSubview(comments)
    
    comments.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    comments.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    comments.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    comments.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    
    title = "Comments"
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(submitTapped))
    comments.text = placeholder
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}
