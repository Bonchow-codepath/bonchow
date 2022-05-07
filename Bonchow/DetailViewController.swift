//
//  DetailViewController.swift
//  Bonchow
//
//  Created by Yvonne511 on 2022/4/30.
//

import UIKit
import MapKit
import Parse

class DetailViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var resMapView: MKMapView!
    @IBOutlet weak var resName: UILabel!
    @IBOutlet weak var resAddress: UILabel!
    @IBOutlet weak var resCategory: UILabel!
    
    var latitude: Double!
    var longitude: Double!
    
    var restaurant: [String:Any]!
    
    
    @IBOutlet weak var sessionStatusLabel: UILabel!
    @IBOutlet weak var sessionActionButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        print(restaurant)
        resName.text = restaurant["name"] as? String
        let location = restaurant["location"] as? NSDictionary
        resAddress.text = location!["address1"] as? String
        let coordinates = restaurant["coordinates"] as? NSDictionary
        let resType = restaurant["categories"] as! [[String:Any?]]
    
        for type in resType {
            let kind = type["title"] as! String
            resCategory.text! += " | "
            resCategory.text! += kind
        }
        
        latitude = coordinates!["latitude"] as? Double
        longitude = coordinates!["longitude"] as? Double
        
        
        //        Set map location
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        resMapView.setRegion(region, animated: true)
        let pinAnnotation = PinAnnotation()
        pinAnnotation.setCoordinate(newCoordinate: coordinate)
        resMapView.addAnnotation(pinAnnotation)
        
        
        //                Set Button Text
        var query = PFQuery(className:"Restaurants")
        query.whereKey("name", equalTo: resName.text)
        query.findObjectsInBackground (block: { (objects: [PFObject]?, error: Error?) in
            let noGroup = objects!.isEmpty as Bool
            var restaurant = PFObject(className:"Restaurants")
            if (noGroup) {
                self.sessionActionButton.setTitle("Start Session", for: .normal)
                
                self.sessionStatusLabel.text = "No Active Sessions"
                }
            else {
                self.sessionActionButton.setTitle("Join Session", for: .normal)
                
                self.sessionStatusLabel.text = "1 Active Session"
                }
            }
        )
    }
    
    
    @IBAction func confirmGroup(_ sender: Any) {
        
        var query = PFQuery(className:"Restaurants")
        query.whereKey("name", equalTo: resName.text)
        query.findObjectsInBackground (block: { (objects: [PFObject]?, error: Error?) in
            let noGroup = objects!.isEmpty as Bool
            var restaurant = PFObject(className:"Restaurants")
            if (noGroup) {
                //print(objects)
                restaurant["name"] = self.resName.text
                restaurant.add(PFUser.current(), forKey: "owners")
                restaurant.saveInBackground {
                    (success: Bool, error: Error?) in
                    if (success) {
                        print("group created")
                        
                        self.performSegue(withIdentifier: "sessionSegue", sender: self.restaurant)
                        
                        
                    } else {
                        print("group created fail")
                    }
                }
            } else {
                restaurant = objects![0]
                restaurant.add(PFUser.current(), forKey: "owners")
                restaurant.saveInBackground {
                    (success: Bool, error: Error?) in
                    if (success) {
                        print("group joined")

                        self.performSegue(withIdentifier: "sessionSegue", sender: self.restaurant)
                    } else {
                        print("group joined fail")
                    }
                }
            }
        }
        )
        
        
        
        
//        let restaurant = PFObject(className:"Restaurants")
//        restaurant["name"] = resName
//        restaurant["guests"] = PFUser.current()
//
//        PFUser.current()?.add(restaurant, forKey: "restaurant")

        
    }
    
    @IBAction func getDirection(_ sender: Any) {
        let lat = latitude as CLLocationDegrees
        let long = longitude as CLLocationDegrees
        let regionDistance = 1000 as CLLocationDistance
        let coordinates = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let regionSpan = MKCoordinateRegion(center: coordinates,latitudinalMeters: regionDistance,longitudinalMeters: regionDistance)
        let options = [MKLaunchOptionsMapCenterKey:NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey:NSValue(mkCoordinateSpan: regionSpan.span)]
        let placeMark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placeMark)
        mapItem.name = resName.text
        mapItem.openInMaps(launchOptions: options)
    }
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if (segue.identifier == "sessionSegue") {
          let sessionViewController = segue.destination as! SessionViewController
          let object = sender as! [String: Any?]
//           print("line177 sender")
//           print(sender!)
//           print("line179 sender")
           sessionViewController.restaurant = sender as! [String : Any]
       }
    }
    
}
