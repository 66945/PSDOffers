//
//  OfferCell.swift
//  PSDOffers
//
//  Created by McGrath, Daniel - Student on 3/1/23.
//

import UIKit

protocol OfferCellProtocol: AnyObject {
    func expandButtonPressedAt(indexPath: IndexPath)
}

class OfferCell: UITableViewCell {
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var expandButton: UIButton!
    @IBOutlet weak var offerLabel: UILabel!

    weak var delegate: OfferCellProtocol?
    var isExpanded: Bool = false
    var indexPath = IndexPath()

    @objc func expandButtonPressed() {
        let duration: TimeInterval = 0.5
        let nextExpanded = !isExpanded
        UIView.animate(withDuration: duration, animations: {
            self.expandButton.transform = CGAffineTransformMakeRotation(nextExpanded ? .pi * 0.5 : 0)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: {
            self.delegate?.expandButtonPressedAt(indexPath: self.indexPath)
        })
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        expandButton.addTarget(self, action: #selector(expandButtonPressed), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func config(offer: Offer, isExpanded: Bool, indexPath: IndexPath, delegate: OfferCellProtocol) {
        name.text = offer.name
        logo.image = offer.logoImg
        offerLabel.text = offer.details.first

        self.isExpanded = isExpanded
        self.indexPath = indexPath
        self.delegate = delegate

        expandButton.transform = CGAffineTransformMakeRotation(isExpanded ? .pi * 0.5 : 0)
    }
}
