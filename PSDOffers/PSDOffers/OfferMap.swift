//
//  OfferMap.swift
//  PSDOffers
//
//  Created by McGrath, Daniel - Student on 3/1/23.
//

import UIKit
import MapKit

class OfferMap: UIViewController {
    var offerings: [MKMapItem] = []
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var currentMapItem = MKMapItem()
        let coordinate = annotation.coordinate
        for mapitem in offerings {
            if mapitem.placemark.coordinate.latitude == coordinate.latitude &&
                
                mapitem.placemark.coordinate.longitude == coordinate.longitude {
                
                currentMapItem = mapitem
            }
        }
        var pin = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        if let title = annotation.title, let actualTitle = title {
            if actualTitle == "blue credit 1" { //This name depends on where you set simulator location
                pin.image = UIImage(named: "PinMage")
            } else {
                let marker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: nil)
                marker.markerTintColor = .blue
                pin = marker
            }
        }
        return pin
        
        
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
