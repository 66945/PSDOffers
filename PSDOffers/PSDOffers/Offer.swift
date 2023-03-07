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
    static func loadOffers() {
        print("Loading offers.")
        if let url = Bundle.main.url(forResource: "offers", withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let nextOffers = try decoder.decode([Offer].self, from: jsonData)
                Offer.offers = nextOffers
            } catch {
                print("error:\(error)")
            }
        }

    }
    
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

extension CLLocationCoordinate2D: Codable {
    public enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.init()
        latitude = try values.decode(Double.self, forKey: .latitude)
        longitude = try values.decode(Double.self, forKey: .longitude)
    }

    
}

extension Offer: Codable {

}

extension [Offer] {
    var json: Data? {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self) {
            return encoded
        }
        return nil
    }
}
