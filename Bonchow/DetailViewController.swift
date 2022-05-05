//
//  DetailViewController.swift
//  Bonchow
//
//  Created by Yvonne511 on 2022/4/30.
//

import UIKit
import MapKit
import Parse

class DetailViewController: UIViewController {

    @IBOutlet weak var resMapView: MKMapView!
    @IBOutlet weak var resName: UILabel!
    @IBOutlet weak var resAddress: UILabel!
    
    var latitude: Double!
    var longitude: Double!
    
    
    var restaurant: [String:Any]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(restaurant)
        resName.text = restaurant["name"] as? String
        let location = restaurant["location"] as? NSDictionary
        resAddress.text = location!["address1"] as? String
        let coordinates = restaurant["coordinates"] as? NSDictionary
        latitude = coordinates!["latitude"] as? Double
        longitude = coordinates!["longitude"] as? Double
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func confirmGroup(_ sender: Any) {
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
