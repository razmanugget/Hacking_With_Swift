//
//  ViewController.swift
//  Capital Cities
//
//  Created by home on 5/24/18.
//  Copyright © 2018 LyfeBug. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
  @IBOutlet weak var mapView: MKMapView!
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    // define a reuse ID
    let identifier = "Capital"
    // check whether annotation created is a capital
    if annotation is Capital {
      // dequeue an anno view for the map view
      var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
      if annotationView == nil {
        // if no reusable view, use MKPinAnnoView
        annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        annotationView!.canShowCallout = true
        // create a new UIButton
        let btn = UIButton(type: .detailDisclosure)
        annotationView!.rightCalloutAccessoryView = btn
      } else {
        // if reusing a view, update w/ different anno
        annotationView!.annotation = annotation
      }
      return annotationView
    }
    // if anno isn't from a capital city, return nil
    return nil
  }
  
  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    let capital = view.annotation as! Capital
    let placeName = capital.title
    let placeInfo = capital.info
    
    let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK",style: .default))
    present(ac, animated: true)
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
    let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
    let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
       let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
    let washington = Capital(title: "Washington", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
    
    mapView.addAnnotations([london, oslo, paris, rome, washington])
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

