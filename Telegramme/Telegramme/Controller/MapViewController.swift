//
//  MapViewController.swift
//  Telegramme
//
//  Created by hwen on 5/1/21.
//

import Foundation
import UIKit
import CoreLocation
import MapKit


class MapViewController : UIViewController, MKMapViewDelegate{
    @IBOutlet weak var map: MKMapView!
    let locationDelegate = LocationDelegate()
    var latestLocation: CLLocation? = nil
    var NPLocation: CLLocation? = nil
    var zoomNP: Bool = true
    
    let locationManager: CLLocationManager = {
        $0.requestWhenInUseAuthorization()
        $0.desiredAccuracy = kCLLocationAccuracyBest
        $0.startUpdatingLocation()
        $0.startUpdatingHeading()
        return $0
    }(CLLocationManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = locationDelegate
        self.setNPLocation()
        
        locationDelegate.locationCallback = { location in
            self.latestLocation = location
            let lat = String(format: "Lat: %3.8f", location.coordinate.latitude)
            let long = String(format: "Long: %3.8f", location.coordinate.longitude)
            print("\(lat), \(long)")
            
            self.annotateCurrentLocation(location)
            
        }
    }
    
    let regionRadius: CLLocationDistance = 250
    func centerMapOnLocation(_ location: CLLocation){
        let coordinateRegion = MKCoordinateRegion (
             center: location.coordinate,
             latitudinalMeters: regionRadius,
             longitudinalMeters: regionRadius)
         
        map.setRegion(coordinateRegion, animated: true)
    }
    
    // remove all the annotations except for NP
    // as the annotation will be drawed everytime when there is location callback
    func removeAllAnnotations(){
        let allAnnotations = self.map.annotations.filter { (annotation) in
            guard let title = annotation.title else {return false}
            return title != "Ngee Ann Polytechnic"
        }
        
        self.map.removeAnnotations(allAnnotations)
    }
    
    func annotateCurrentLocation(_ location: CLLocation){
        self.removeAllAnnotations()

        let annotation = MKPointAnnotation()

        annotation.coordinate = location.coordinate
        annotation.title = "Me"
        self.map.addAnnotation(annotation)
        
        if !self.zoomNP{
            self.centerMapOnLocation(location)
        }
    }
    
    func annotateNP(){
        let annotation = MKPointAnnotation()

        annotation.coordinate = self.NPLocation!.coordinate
        annotation.title = "Ngee Ann Polytechnic"
        annotation.subtitle = "School of ICT"
        self.map.addAnnotation(annotation)

        self.centerMapOnLocation(self.NPLocation!)
    }
    
    func setNPLocation(){
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(
            "535 Clementi Road Singapore 599489",
            completionHandler: {p,e in
                
                let lat:CLLocationDegrees = p![0].location!.coordinate.latitude
                let long:CLLocationDegrees = p![0].location!.coordinate.longitude

                print("\(lat), \(long)")

                self.NPLocation = CLLocation(latitude: lat, longitude: long)
                self.annotateNP()
            }
        )
    }

    @IBAction func zoomNP(_ sender: Any) {
        self.zoomNP = true
        self.centerMapOnLocation(self.NPLocation!)
    }
    
    
    @IBAction func zoomCurrent(_ sender: Any) {
        self.zoomNP = false
        self.centerMapOnLocation(self.latestLocation!)
    }
    
    
}
