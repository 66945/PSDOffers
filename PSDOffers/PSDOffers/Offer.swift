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
