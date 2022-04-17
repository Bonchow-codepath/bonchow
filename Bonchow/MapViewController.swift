//
//  MapViewController.swift
//  Bonchow
//
//  Created by Anagh Kanungo on 02/04/22.
//

import UIKit
import GoogleMaps
import Parse

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    //    To fetch current location
    var locationManagerVar = CLLocationManager()
//    lazy var mapView = GMSMapView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.settings.myLocationButton = true;
        
//        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 13.0)
//        mapView.camera = camera;
        
        // User Location
        locationManagerVar.delegate = self
        locationManagerVar.requestWhenInUseAuthorization()
        locationManagerVar.desiredAccuracy = kCLLocationAccuracyBest
        locationManagerVar.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.authorizedWhenInUse)
          {
            mapView.isMyLocationEnabled = true
          }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last
        mapView.camera = GMSCameraPosition.camera(withTarget: newLocation!.coordinate, zoom: 13.0)
        
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
