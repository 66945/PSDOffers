//
//  OfferCell.swift
//  PSDOffers
//
//  Created by McGrath, Daniel - Student on 3/1/23.
//

import UIKit

class OfferCell: UITableViewCell {
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func config(offer: Offer) {
        name.text = offer.name
        logo.image = offer.logoImg
    }
}
