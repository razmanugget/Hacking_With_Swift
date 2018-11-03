//
//  ViewController.swift
//  Detect a Beacon
//
//  Created by home on 5/29/18.
//  Copyright © 2018 LyfeBug. All rights reserved.
//

/* Rami Notes
 * used "When in Use" instead of "Always" for the beacon setting (plist and below)
 * seems to work better to delete the app and force it to request permission when testing
 *
 * to find with Locate app, use Apple AirLocate 5A4BCFCE for broadcasting
 *
 */

import UIKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {
  
  // MARK: - Variables
  var locationManager: CLLocationManager!
  
  @IBOutlet weak var distanceReading: UILabel!
  
  // MARK: - Functions
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedWhenInUse {   // was .authorizedAlways
      if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
        if CLLocationManager.isRangingAvailable() {
          startScanning()
        }
      }
    }
  }
  
  func startScanning() {
    let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
    let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 123, minor: 456, identifier: "MyBeacon")
    
    locationManager.startMonitoring(for: beaconRegion)
    locationManager.startRangingBeacons(in: beaconRegion)
  }
  
  func update(distance: CLProximity) {
    UIView.animate(withDuration: 0.8) { [unowned self] in
      switch distance {
      case .unknown:
        self.view.backgroundColor = UIColor.gray
        self.distanceReading.text = "UNKNOWN"
      case .far:
        self.view.backgroundColor = UIColor.blue
        self.distanceReading.text = "FAR"
      case .near:
        self.view.backgroundColor = UIColor.orange
        self.distanceReading.text = "NEAR"
      case .immediate:
        self.view.backgroundColor = UIColor.red
        self.distanceReading.text = "RIGHT HERE"
      }
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
    if beacons.count > 0 {
      let beacon = beacons[0]
      update(distance: beacon.proximity)
    } else {
      update(distance: .unknown)
    }
  }
  
  // MARK: - Override Functions
  override func viewDidLoad() {
    super.viewDidLoad()
    
    locationManager = CLLocationManager()
    locationManager.delegate = self
    locationManager.requestWhenInUseAuthorization()  // or use .requestWhenInUseAuthorization() if necessary
  
    view.backgroundColor = UIColor.gray
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}

