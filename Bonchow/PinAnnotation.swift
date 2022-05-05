import MapKit
import Foundation
import UIKit

class PinAnnotation : NSObject, MKAnnotation {
    private var coord: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    private var _title: String = String("")
    private var _name: String = String("")
    private var _subtitle: String = String("")
    private var _restaurant: [String:Any?] = [:]
    private var _id: String = String("")

    var coordinate: CLLocationCoordinate2D {
        get {
            return coord
        }
    }

    func setCoordinate(newCoordinate: CLLocationCoordinate2D) {
        self.coord = newCoordinate
    }

    var title: String? {
        get {
            return _title
        }
        set (value) {
            self._title = value!
        }
    }
    
    var name: String? {
        get {
            return _name
        }
        set (value) {
            self._name = value!
        }
    }
    
    var id: String? {
        get {
            return _id
        }
        set (value) {
            self._id = value!
        }
    }

    var subtitle: String? {
        get {
            return _subtitle
        }
        set (value) {
            self._subtitle = value!
        }
    }
    
    var restaurant: [String:Any?] {
        get {
            return _restaurant
        }
        set (value) {
            self._restaurant = value
        }
    }
    
}
