//
//  MapViewController.swift
//  Bonchow
//
//  Created by Anagh Kanungo on 02/04/22.
//

import UIKit
import Parse
import Foundation
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let manager = CLLocationManager()
    
    var userLocation: CLLocation!
    
    
    
    
    
    
    var a = 0.0
    var b = 0.0
    
    var restaurantsArray: [[String:Any?]] = []
    
    var pins: [MKPointAnnotation] = []
    
    var pins2: [PinAnnotation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            manager.stopUpdatingLocation()
            print(location.coordinate.latitude)
            print(location.coordinate.longitude)
            render(location)
            getRestaurants(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
    }
    
    func render(_ location : CLLocation) {
        
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        
        
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        mapView.setRegion(region, animated: true)
        
        
    }
    
    
    func getRestaurants(latitude: Double, longitude: Double) {
        self.getAPIData(latitude: latitude, longitude: longitude)
    }
    
    func getAPIData(latitude : Double, longitude : Double ) {
        yelpAPI.getRestaurants(latitude: latitude, longitude: longitude){
            (restaurants) in guard let restaurants = restaurants else {
                print("did not work!")
                return
            }
            self.restaurantsArray = restaurants
            print(self.restaurantsArray)
            for restaurant in self.restaurantsArray {
                
//                let marker = MKPointAnnotation()
                let resTitle = restaurant["name"] as! String
                let resType = restaurant["categories"] as! [[String:Any?]]
                let coordinates = restaurant["coordinates"] as! NSDictionary
                let latitude = coordinates["latitude"] as! CLLocationDegrees
                let longitude = coordinates["longitude"] as! CLLocationDegrees
                
                
                let pinAnnotation = PinAnnotation()
                pinAnnotation.setCoordinate(newCoordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
                pinAnnotation.title = resTitle
                pinAnnotation.subtitle = ""
                for type in resType{
                    let kind = type["title"] as! String
                    pinAnnotation.subtitle! += " "
                    pinAnnotation.subtitle! += kind
                }
                
                self.pins2.append(pinAnnotation)
                self.mapView.addAnnotation(pinAnnotation)
                
                //                Set markers
//                marker.coordinate.latitude = latitude
//                marker.coordinate.longitude = longitude
//                marker.title = resTitle
//                marker.subtitle = ""
//                for type in resType{
//                    let kind = type["title"] as! String
//                    marker.subtitle! += " "
//                    marker.subtitle! += kind
//                }
//                self.pins.append(marker)
//                self.mapView.addAnnotation(marker)
                
                
            }
        }

    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//            print("Function called!")
            if annotation is PinAnnotation {
                let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myPin")

                pinAnnotationView.pinTintColor = .purple
                pinAnnotationView.isDraggable = true
                pinAnnotationView.canShowCallout = true
                pinAnnotationView.animatesDrop = true

                let startSessionButton = UIButton(type: UIButton.ButtonType.custom) as UIButton
                startSessionButton.frame.size.width = 44
                startSessionButton.frame.size.height = 44
                startSessionButton.backgroundColor = UIColor.green
                startSessionButton.setImage(UIImage(named: "add"), for: [])
  
                pinAnnotationView.rightCalloutAccessoryView = startSessionButton

                return pinAnnotationView
            }

            return nil
    }

    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            if let annotation = view.annotation as? PinAnnotation {
                print(view.annotation?.title!)
            }
        
    }
    
    


    
    
    
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
//        {
//            print("work")
//            if let annotationTitle = view.annotation?.title
//            {
//                print("User tapped on annotation with title: \(annotationTitle!)")
//            }
//        }
    
    
    
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        print("didChangeAuthorization called")
//        if (status == CLAuthorizationStatus.authorizedWhenInUse)
//          {
//            mapView.isMyLocationEnabled = true
//          }
//    }
    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("exiting because of error")
//        exit(1)
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//       print("didUpdateLocations called")
//
//        let newLocation = locations.last
//        mapView.camera = GMSCameraPosition.camera(withTarget: newLocation!.coordinate, zoom: 13.0)
//
//
//        let lat = Double((newLocation?.coordinate.latitude)!)
//        let lon = Double((newLocation?.coordinate.longitude)!)
//
//        print(lat)
//        print(lon)
//
//        self.a = Double(lat)
//        self.b = Double(lon)
        
//        print(restaurantsArray)
//        print(restaurantsArray.count)
        
        //let restaurants: [[String:Any?]] = getAPIdata(latitude: a, longitude: b)
        //let restaurants = getAPIdata(latitude: lat, longitude: lon)
        //print(restaurants)
        
//        for restaurant in self.restaurantsArray {
//
//            let coordinates = restaurant["coordinates"] as! NSDictionary
//            let latitude = coordinates["latitude"] as! CLLocationDegrees
//            let longitude = coordinates["longitude"] as! CLLocationDegrees
//
//
//            let position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//            let marker = GMSMarker(position: position)
//
//            marker.title = restaurant["title"] as? String ?? ""
//
//            //print(latitude)
//            //print(longitude)
//
//            marker.map = mapView
//        }
        
        
//        x["coordinates"].latitude
        
        
        
//    }
        
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        let main = UIStoryboard(name: "Main", bundle: nil)
        let SetupViewController = main.instantiateViewController(withIdentifier: "SetupViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else {return}
        
        delegate.window?.rootViewController = SetupViewController
    }
    
    
 
}
