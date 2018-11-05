//
//  ViewController.swift
//  Secret Swift
//
//  Created by home on 6/12/18.
//  Copyright © 2018 LyfeBug. All rights reserved.
//

import LocalAuthentication
import UIKit

// MARK: - Extensions



class ViewController: UIViewController {
  // MARK: - Variables
  @IBOutlet weak var secret: UITextView!
  
  // MARK: - IBActions
  @IBAction func authenticateTapped(_ sender: Any) {
    let context = LAContext()
    var error: NSError?
    
    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
      let reason = "Identify yourself!"
      
      context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
        [unowned self] (success, authenticationError) in
        
        DispatchQueue.main.async {
          if success {
            self.unlockSecretMessage()
          } else {
            // error
            let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
          }
        }
      }
    } else {
      // no biometry
      let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication.", preferredStyle: .alert)
      ac.addAction(UIAlertAction(title: "OK", style: .default))
      self.present(ac, animated: true)
    }
  }
    
    
  
      
  
  // MARK: - Functions
  func unlockSecretMessage() {
    secret.isHidden = false
    title = "Secret stuff!"
    
    if let text = KeychainWrapper.standard.string(forKey: "SecretMessage") {
      secret.text = text
    }
  }
  
  
  @objc func adjustForKeyboard(notification: Notification) {
    let userInfo = notification.userInfo!
    
    let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
    let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
    
    if notification.name == UIResponder.keyboardWillHideNotification {
      secret.contentInset = UIEdgeInsets.zero
    } else {
      secret.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
    }
    
    secret.scrollIndicatorInsets = secret.contentInset
    
    let selectedRange = secret.selectedRange
    secret.scrollRangeToVisible(selectedRange)
  }
  
  @objc func saveSecretMessage() {
    if !secret.isHidden {
      _ = KeychainWrapper.standard.set(secret.text, forKey: "SecretMessage")
      secret.resignFirstResponder()
      secret.isHidden = true
      title = "Nothing to see here"
    }
  }
  
  
  // MARK: - Override Functions
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Nothing to see here"
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    
    notificationCenter.addObserver(self, selector: #selector(saveSecretMessage), name: UIApplication.willResignActiveNotification, object: nil)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

