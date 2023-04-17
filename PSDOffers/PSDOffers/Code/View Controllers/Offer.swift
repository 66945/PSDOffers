//
//  Offer.swift
//  PSDOffers
//
//  Created by McGrath, Daniel - Student on 3/1/23.
//

import Foundation
import MapKit

struct UrlButton: Codable {
    var showName: String
    var url: String
}
struct EmailButton: Codable {
   // var showName: String
    var address: String
}

struct Offer {
    var name:    String = ""
    var details: [String]?
    var logoURL: String?        // = nil
    var addresses: [String]? // = nil
    var addressIndex: Int?
    
    var buttons: [UrlButton]?
    var emailButtons: [EmailButton]?
    var categories: [String]?

}

extension Offer {
    static var empty = Offer()
    
    var validCategories: [Category] {
        var next: [Category] = []
        if let cats = categories {
            for category in cats {
                if let category = Category(rawValue: category) {
                    next.append(category)
                }else{
                    print("ERROR: Bad category: \(category)")
                }
            }
        }
        return next
    }
    
    
    static var offers: [Offer] = [
        Offer(name: "Test", addresses: Optional(["1033 S Taft Hill Rd, Fort Collins, CO"]))
//        Offer(name: "Cups Coffee", details: ["10% off"], logoURL: "sample_logo", addresses: [], location: [CLLocationCoordinate2D(latitude: 40.57306523957938, longitude: -105.11530191349455)], buttons: [], emailButtons: []),
//        Offer(name: "Blue Federal Credit Union", details: ["Free checking"], logoURL: "sample_logo", addresses: [], location: [CLLocationCoordinate2D(latitude: 40.53243070893257, longitude: -105.07849515554979)], buttons: [], emailButtons: []),
//        Offer(name: "Name 1", details: [], logoURL: "sample_logo", addresses: [], location: [], buttons: [], emailButtons: []),
//        Offer(name: "Jakob",  details: [], logoURL: nil, addresses: [], location: [], buttons: [], emailButtons: []),
//        Offer(name: "Sample", details: [], logoURL: "sample_logo", addresses: [], location: [], buttons: [], emailButtons: []),
//        Offer(name: "John",   details: [], logoURL: nil, addresses: [], location: [], buttons: [], emailButtons: [EmailButton(address: "joe@x.com")]),
    ]
    static func loadOffers() {
        print("Loading offers.")
        if let url = Bundle.main.url(forResource: "offers", withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let nextOffers = try decoder.decode([Offer].self, from: jsonData)
                let sortedOffers = nextOffers.sorted(by: { $0.name < $1.name })
                Offer.offers = sortedOffers
            } catch {
                print("error:\(error)")
            }
        }

    }
    

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
