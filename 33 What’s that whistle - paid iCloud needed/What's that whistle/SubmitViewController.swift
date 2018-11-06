//
//  SubmitViewController.swift
//  What's that whistle
//
//  Created by home on 6/17/18.
//  Copyright © 2018 LyfeBug. All rights reserved.
//

import UIKit
import CloudKit // stopped here  -> need paid dev acct for cloudkit

class SubmitViewController: UIViewController {
  var genre: String!
  var comments: String!
  
  var stackView: UIStackView!
  var status: UILabel!
  var spinner: UIActivityIndicatorView!
  
  
  func doSubmission() {
    
  }
  
  
  @objc func doneTapped() {
    _ = navigationController?.popToRootViewController(animated: true)
  }
  
  override func loadView() {
    super.loadView()
    
    view.backgroundColor = UIColor.gray
    stackView = UIStackView()
    stackView.spacing = 10
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.distribution = UIStackViewDistribution.fillEqually
    stackView.alignment = .center
    stackView.axis = .vertical
    view.addSubview(stackView)
    
    stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    
    status = UILabel()
    status.translatesAutoresizingMaskIntoConstraints = false
    status.text = "Submitting…"
    status.textColor = UIColor.white
    status.font = UIFont.preferredFont(forTextStyle: .title1)
    status.numberOfLines = 0
    status.textAlignment = .center
    
    spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    spinner.translatesAutoresizingMaskIntoConstraints = false
    spinner.hidesWhenStopped = true
    spinner.startAnimating()
    
    stackView.addArrangedSubview(status)
    stackView.addArrangedSubview(spinner)
  }
  
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    doSubmission()
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "You're all set!"
    navigationItem.hidesBackButton = true
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}
