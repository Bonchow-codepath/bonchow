//
//  MapViewController.swift
//  Bonchow
//
//  Created by Anagh Kanungo on 02/04/22.
//

import UIKit
//import GoogleMaps
import Parse
import Foundation
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
//    @IBOutlet weak var mapView: GMSMapView!
    
    let manager = CLLocationManager()
    
    var userLocation: CLLocation!
    
    var a = 0.0
    var b = 0.0
    
    var restaurantsArray: [[String:Any?]] = []
    
    var pins: [MKPointAnnotation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        mapView = MKMapView()
//        mapView.delegate = self
//        mapView.isZoomEnabled = true
//        mapView.isScrollEnabled = true
        getRestaurants()
    }
    
    func getRestaurants(){
        LocationManager.shared.getUserLocation{ [weak self] location in
            DispatchQueue.main.async {
                guard let strongSelf = self else {
                    return
                }
//                let pin = MKPointAnnotation()
//                pin.coordinate = location.coordinate
                self!.userLocation = location
                self!.a = self!.userLocation.coordinate.latitude
                self!.b = self!.userLocation.coordinate.longitude
                self!.getAPIdata(latitude: self!.a, longitude: self!.b)
                print(self!.a)
                print(self!.b)
                print(self!.restaurantsArray)
                //print(self!.pins) does not work
                strongSelf.mapView.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)), animated:true)
//                strongSelf.appleMapView.addAnnotation(pin)
            }
        }
    }
    
    func getAPIdata(latitude : Double, longitude : Double ) {
        yelpAPI.getRestaurants(latitude: latitude, longitude: longitude){
            (restaurants) in guard let restaurants = restaurants else {
                print("did not work!")
                return
            }
            self.restaurantsArray = restaurants
            for restaurant in self.restaurantsArray {
                let marker = MKPointAnnotation()
                let resTitle = restaurant["name"] as! String
                let resType = restaurant["categories"] as! [[String:Any?]]
                let coordinates = restaurant["coordinates"] as! NSDictionary
                let latitude = coordinates["latitude"] as! CLLocationDegrees
                let longitude = coordinates["longitude"] as! CLLocationDegrees
                marker.coordinate.latitude = latitude
                marker.coordinate.longitude = longitude
                marker.title = resTitle
                marker.subtitle = ""
                for type in resType{
                    let kind = type["title"] as! String
                    marker.subtitle! += " "
                    marker.subtitle! += kind
                }
                
                self.pins.append(marker)
                //print(self.pins)
                //<a href="https://www.flaticon.com/free-icons/food" title="food icons">Food icons created by André Luiz Gollo - Flaticon</a>
                //marker.image =
                self.mapView.addAnnotation(marker)
            }
        }

    }

    
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
        {
            print("work")
            if let annotationTitle = view.annotation?.title
            {
                print("User tapped on annotation with title: \(annotationTitle!)")
            }
        }
    
    
    
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
