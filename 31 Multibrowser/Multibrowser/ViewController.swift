//
//  ViewController.swift
//  Multibrowser
//
//  Created by home on 6/15/18.
//  Copyright © 2018 LyfeBug. All rights reserved.
//

import UIKit

// MARK: - Extensions

class ViewController: UIViewController, UIWebViewDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate {
  // MARK: - Variables
  weak var activeWebView: UIWebView?
  @IBOutlet weak var addressBar: UITextField!
  @IBOutlet weak var stackView: UIStackView!
  
  // MARK: - IBActions
  
  
  // MARK: - Functions
  func setDefaultTitle() {
    title = "Multibrowser"
  }
  
  func selectWebView(_ webView: UIWebView) {
    for view in stackView.arrangedSubviews {
      view.layer.borderWidth = 0
    }
    activeWebView = webView
    webView.layer.borderWidth = 3
    updateUI(for: webView)
  }
  
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if let webView = activeWebView, let address = addressBar.text {
      if let url = URL(string: address) {
        webView.loadRequest(URLRequest(url: url))
      }
    }
    textField.resignFirstResponder()
    return true
  }
  
  func updateUI(for webView: UIWebView) {
    title = webView.stringByEvaluatingJavaScript(from: "document.title")
    addressBar.text = webView.request?.url?.absoluteString ?? ""
  }
  
  func webViewDidFinishLoad(_ webView: UIWebView) {
    if webView == activeWebView {
      updateUI(for: webView)
    }
  }
  
  @objc func addWebView() {
    let webView = UIWebView()
    webView.delegate = self
    
    stackView.addArrangedSubview(webView)
    
    let url = URL(string: "https://www.hackingwithswift.com")!
    webView.loadRequest(URLRequest(url: url))
    
    webView.layer.borderColor = UIColor.blue.cgColor
    selectWebView(webView)
    
    let recognizer = UITapGestureRecognizer(target: self, action: #selector(webViewTapped))
    recognizer.delegate = self
    webView.addGestureRecognizer(recognizer)
  }
  
  @objc func deleteWebView() {
    // safely unwrap our webview
    if let webView = activeWebView {
      if let index = stackView.arrangedSubviews.firstIndex(of: webView) {
        // found the current webview in the stack view and remove
        stackView.removeArrangedSubview(webView)
        // now remove it from the view hierarchy - important!!!!  otherwise = mem leak
        webView.removeFromSuperview()
        if stackView.arrangedSubviews.count == 0 {
          // go back to our default UI
          setDefaultTitle()
        } else {
          // convert the Index value into an integer
          var currentIndex = Int(index)
          // if that was the last web view in the stack, go back one
          if currentIndex == stackView.arrangedSubviews.count {
            currentIndex = stackView.arrangedSubviews.count - 1
          }
          // find the web view at the next index and select it
          if let newSelectedWebView = stackView.arrangedSubviews[currentIndex] as? UIWebView {
            selectWebView(newSelectedWebView)
          }
        }
      }
    }
  }
  
  @objc func webViewTapped(_ recognizer: UITapGestureRecognizer) {
    if let selectedWebView = recognizer.view as? UIWebView {
      selectWebView(selectedWebView)
    }
  }
  
  // MARK: - Override Functions
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setDefaultTitle()
    
    let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWebView))
    let delete = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteWebView))
    navigationItem.rightBarButtonItems = [delete, add]
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    if traitCollection.horizontalSizeClass == .compact {
      stackView.axis = .vertical
    } else {
      stackView.axis = .horizontal
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

