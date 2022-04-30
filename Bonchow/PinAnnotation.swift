import MapKit
import Foundation
import UIKit

class PinAnnotation : NSObject, MKAnnotation {
    private var coord: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    private var _title: String = String("")
    private var _subtitle: String = String("")

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

    var subtitle: String? {
        get {
            return _subtitle
        }
        set (value) {
            self._subtitle = value!
        }
    }
    
}
