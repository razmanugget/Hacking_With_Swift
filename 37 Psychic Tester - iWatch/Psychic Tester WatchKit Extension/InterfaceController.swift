//
//  InterfaceController.swift
//  Psychic Tester WatchKit Extension
//
//  Created by home on 6/28/18.
//  Copyright © 2018 LyfeBug. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate {
  
  @IBOutlet var welcomeText: WKInterfaceLabel!
  @IBOutlet var hideButton: WKInterfaceButton!
  
  @IBAction func hideWelcomeText() {
    welcomeText.setHidden(true)
    hideButton.setHidden(true)
  }
  
  
  func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
    WKInterfaceDevice().play(.click)
  }
  
  
  func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
  }
  
  
  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    
    // Configure interface objects here.
  }
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
    
    if WCSession.isSupported() {
      let session = WCSession.default
      session.delegate = self
      session.activate()
    }
  }
  
  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }
  
}
