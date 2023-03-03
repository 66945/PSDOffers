//
//  Offer.swift
//  PSDOffers
//
//  Created by McGrath, Daniel - Student on 3/1/23.
//

import Foundation
import MapKit

struct Offer {
    static var offers: [Offer] = [
        Offer(name: "Cups Coffee", details: ["10% off"], logoURL: "sample_logo", location: [CLLocationCoordinate2D(latitude: 40.57306523957938, longitude: -105.11530191349455)]),
        Offer(name: "Blue Federal Credit Union", details: ["Free checking"], logoURL: "sample_logo", location: [CLLocationCoordinate2D(latitude: 40.53243070893257, longitude: -105.07849515554979)]),
        Offer(name: "Name 1", details: [], logoURL: "sample_logo", location: []),
        Offer(name: "Jakob",  details: [], logoURL: nil,           location: []),
        Offer(name: "Sample", details: [], logoURL: "sample_logo", location: []),
        Offer(name: "John",   details: [], logoURL: nil,           location: []),
    ]
    static func loadOffers() {}
    
    let name:    String
    let details: [String]
    let logoURL: String?
    
    let location: [CLLocationCoordinate2D]
    
    var logoImg: UIImage? {
        if let logoURL = logoURL {
            return UIImage(named: logoURL)
        }
        
        return nil
    }
}
