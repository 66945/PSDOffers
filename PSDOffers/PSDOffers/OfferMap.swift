//
//  OfferMap.swift
//  PSDOffers
//
//  Created by McGrath, Daniel - Student on 3/1/23.
//

import UIKit
import MapKit

class OfferPoint: MKPointAnnotation {
    var offer: Offer = Offer()
}

class OfferPin: MKMarkerAnnotationView {
    var offer: Offer = Offer()
}

class OfferMap: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    // var parks: [MKMapItem] = []
    var offerings: [MKPointAnnotation] = []
    
    func buildAnnotations() {
        for offer in Offer.offers {
            
            if let addresses = offer.addresses {
                for (index, address) in addresses.enumerated() {
                    getCoordinate(addressString: address, completionHandler: { (coordinate, error) in
                        if error == nil {
                            // let anno = MKPointAnnotation()
                            let anno = OfferPoint()
                            anno.offer = offer
                            anno.offer.addressIndex = index
                            anno.title = offer.name
                            anno.coordinate = coordinate
                            self.offerings.append(anno)
                            self.mapView.addAnnotation(anno)
                        } else {
                            // print error
                        }
                    })
                }
            }
        }
    }
    
    func getCoordinate( addressString : String,
                        completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    
                    completionHandler(location.coordinate, nil)
                    return
                }
            }
            
            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
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
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let vc = segue.destination as? OfferListTable {
            if let offer = sender as? Offer {
                vc.offer = offer
            }
        }
    }
        
        
        
        // MARK: - Mapview
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation.isEqual(mapView.userLocation) {
                return nil
            }
            
            var pin = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
            if let offerPoint = annotation as? OfferPoint {
                // let marker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: nil)
                let marker = OfferPin(annotation: annotation, reuseIdentifier: nil)
                marker.offer = offerPoint.offer
                marker.markerTintColor = .blue
                pin = marker
                
                pin.canShowCallout = true
                let button = UIButton(type: .detailDisclosure)
                pin.rightCalloutAccessoryView = button
                let zoomButton = UIButton(type: .contactAdd)
                pin.leftCalloutAccessoryView = zoomButton
            }
            return pin
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            
            let buttonPressed = control as! UIButton
            if buttonPressed.buttonType == .contactAdd {
                print("+ tapped")
                // mapView.setRegion(initialRegion, animated: true)
                let oldSpan = mapView.region.span
                let minSpan = min(oldSpan.latitudeDelta, oldSpan.longitudeDelta)
                if minSpan > 0.06 {
                    
                    let coordinateSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                    if let center = view.annotation?.coordinate {
                        let region = MKCoordinateRegion(center: center, span: coordinateSpan)
                        mapView.setRegion(region, animated: true)
                    }
                } else {
                    let coordinateSpan = MKCoordinateSpan(latitudeDelta: oldSpan.latitudeDelta * 0.5, longitudeDelta: oldSpan.longitudeDelta * 0.5)
                    if let center = view.annotation?.coordinate {
                        let region = MKCoordinateRegion(center: center, span: coordinateSpan)
                        mapView.setRegion(region, animated: true)
                    }
                }
                return
            } else if buttonPressed.buttonType == .detailDisclosure {
                print("show details")
                if let offerPin = view as? OfferPin {
                   // performSegue(withIdentifier: "showOffer", sender: offerPin.offer)
                    let title = offerPin.offer.name
                    var message = ""
                    if let index = offerPin.offer.addressIndex, let addresses = offerPin.offer.addresses {
                        message = addresses[index]
                    }
                    
                    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Show Offer", style: .default, handler: { _ in self.performSegue(withIdentifier: "showOffer", sender: offerPin.offer)}))
                    
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                                    present(alert, animated: true, completion: nil)
                    
                }
                
            }
            
        }
    }

