//
//  OfferMap.swift
//  PSDOffers
//
//  Created by McGrath, Daniel - Student on 3/1/23.
//

import UIKit
import MapKit

class OfferAnnotation: MKPointAnnotation {
    var offer = Offer(name: "", details: [], logoURL: nil, location: [])
}

class OfferMap: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!

    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    // var parks: [MKMapItem] = []
    var offerings: [MKPointAnnotation] = []

    func buildAnnotations() {
        for offer in Offer.offers {
            for location in offer.location {
                let anno = OfferAnnotation()
                anno.title = offer.name
                let text = offer.details.joined(separator: "\n")
                anno.subtitle = text
                anno.coordinate = location
                anno.offer = offer
                offerings.append(anno)
                self.mapView.addAnnotation(anno)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        mapView.delegate = self
        buildAnnotations()

        let coordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let center = CLLocationCoordinate2D(latitude: 40.57, longitude: -105.1)
        let region = MKCoordinateRegion(center: center, span: coordinateSpan)
        mapView.setRegion(region, animated: true)

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


    // MARK: - Mapview

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isEqual(mapView.userLocation) {
            return nil
        }
        var pin = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        let marker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: nil)
        marker.markerTintColor = .blue
        pin = marker

        pin.canShowCallout = true
        let button = UIButton(type: .detailDisclosure)
        pin.rightCalloutAccessoryView = button
        let zoomButton = UIButton(type: .contactAdd)
        pin.leftCalloutAccessoryView = zoomButton
        return pin
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {

        let buttonPressed = control as! UIButton
        if buttonPressed.buttonType == .contactAdd {
            print("+ tapped")
            // mapView.setRegion(initialRegion, animated: true)
            return
        } else if buttonPressed.buttonType == .detailDisclosure {
            print("show details")
            if let anno = view.annotation as? OfferAnnotation {
                let title = anno.title ?? "Title"
                let info = anno.offer.details.joined(separator: "\n")
                let alert = UIAlertController(title: title, message: info, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        }

    }


}
