//
//  ExtString.swift
//  PSDOffers
//
//  Created by Laviolette, Akivah - Student on 4/12/23.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
