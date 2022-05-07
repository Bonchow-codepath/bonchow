//
//  SessionViewController.swift
//  Bonchow
//
//  Created by Anagh Kanungo on 06/05/22.
//

import UIKit
import MapKit
import Parse

class SessionViewController: UIViewController {
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var resName: UILabel!
    @IBOutlet weak var resAddress: UILabel!
    
    var latitude: Double!
    var longitude: Double!
    var restaurant: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardView.layer.cornerRadius = 8
        
        //        Load Restaurant Details
        resName.text = restaurant["name"] as? String
        
        let location = restaurant["location"] as? NSDictionary
        resAddress.text = location!["address1"] as? String

        let coordinates = restaurant["coordinates"] as? NSDictionary
        latitude = coordinates!["latitude"] as? Double
        longitude = coordinates!["longitude"] as? Double
        
        
        //        Load Member Data
    }
    
    @IBAction func onLeaveSession(_ sender: Any) {
        var query = PFQuery(className:"Restaurants")
        query.whereKey("name", equalTo: resName.text)
        query.findObjectsInBackground (block: { (objects: [PFObject]?, error: Error?) in
            var owners = objects![0]["owners"] as! [PFUser]
            //print(owners)
            var removedOwners: [PFUser] = []
            for owner in owners {
                if (owner.objectId != PFUser.current()?.objectId){
                    removedOwners.append(owner)
                    print("added")
                }
            }
            objects![0]["owners"] = removedOwners
//            print("removedOwners")
//            print(removedOwners)
            objects![0].saveInBackground()
//            print("owners")
//            print(objects![0]["owners"])
//            print("on leave")
            let noOwners = removedOwners.isEmpty as Bool
            print(noOwners)
            if (noOwners){
                objects![0].deleteEventually()
                print("deleted")
            }
            
        })
    }
    
    @IBAction func getDirections(_ sender: Any) {
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
