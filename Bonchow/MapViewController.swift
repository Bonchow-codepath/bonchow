//
//  MapViewController.swift
//  Bonchow
//
//  Created by Anagh Kanungo on 02/04/22.
//

import UIKit
import GoogleMaps
import Parse
import Foundation


class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    //    To fetch current location
    var locationManagerVar = CLLocationManager()
//    lazy var mapView = GMSMapView()
    
    var a = 0.0;
    var b = 0.0;
    
    
    var restaurantsArray: [[String:Any?]] = []
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        mapView.settings.myLocationButton = true;
        
//        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 13.0)
//        mapView.camera = camera;
        
        // User Location
        locationManagerVar.delegate = self
        locationManagerVar.requestWhenInUseAuthorization()
        locationManagerVar.desiredAccuracy = kCLLocationAccuracyBest
//        locationManagerVar.startUpdatingLocation()
        
//        locationManagerVar.stopUpdatingLocation()
        let userLocation = locationManagerVar.requestLocation()
//        print("Printing user location!")
//        print(userLocation)
    

//        locationManagerVar.stopUpdatingLocation()
        
//        getAPIdata(latitude: a, longitude: b)
//        print(restaurantsArray)
        
    }
    
    func getAPIdata(latitude : Double, longitude : Double ) -> [[String:Any?]] {
        var restaurants2 : [[String:Any?]] = []
        
        yelpAPI.getRestaurants(latitude: latitude, longitude: longitude){
            (restaurants) in guard let restaurants = restaurants else {
                print("did not work!")
                return
            }
//            print(restaurants)
            self.restaurantsArray = restaurants
            print(self.restaurantsArray)
            //            self.tableView.reloadData()
            restaurants2 = restaurants
//            return restaurants;

        }
        print(restaurants2)
        return restaurants2
    }
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("didChangeAuthorization called")
        if (status == CLAuthorizationStatus.authorizedWhenInUse)
          {
            mapView.isMyLocationEnabled = true
          }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("exiting because of error")
        exit(1)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       print("didUpdateLocations called")
        
        let newLocation = locations.last
        mapView.camera = GMSCameraPosition.camera(withTarget: newLocation!.coordinate, zoom: 13.0)
        
        
        let lat = Double((newLocation?.coordinate.latitude)!)
        let lon = Double((newLocation?.coordinate.longitude)!)

        print(lat)
        print(lon)
        
        self.a = Double(lat)
        self.b = Double(lon)
        
//        print(restaurantsArray)
//        print(restaurantsArray.count)
        
        let restaurants: [[String:Any?]]  = getAPIdata(latitude: a, longitude: b)
        print(restaurants)
        
        for restaurant in restaurants {
            
            let coordinates = restaurant["coordinates"] as! NSDictionary
            let latitude = coordinates["latitude"] as! CLLocationDegrees
            let longitude = coordinates["longitude"] as! CLLocationDegrees


            let position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let marker = GMSMarker(position: position)
            
            marker.title = restaurant["title"] as? String ?? ""
            
            print(latitude)
            print(longitude)

            marker.map = mapView
        }
        
        
//        x["coordinates"].latitude
        
        
        
    }
        
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        let main = UIStoryboard(name: "Main", bundle: nil)
        let SetupViewController = main.instantiateViewController(withIdentifier: "SetupViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else {return}
        
        delegate.window?.rootViewController = SetupViewController
    }
    
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//            let userLocation = locations.last
//            let center = CLLocationCoordinate2D(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude)
//
//            let camera = GMSCameraPosition.camera(withLatitude: userLocation!.coordinate.latitude,
//                                                              longitude: userLocation!.coordinate.longitude, zoom: 13.0)
//            mapView.camera = camera;
//            mapView.isMyLocationEnabled = true
//            self.view = mapView
//
//        locationManagerVar.stopUpdatingLocation()
//        }
    
//    extension ViewController:
//        GMSMapViewDelegate  {
//
//    }
 
}
