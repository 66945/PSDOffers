//
//  OfferCell.swift
//  PSDOffers
//
//  Created by McGrath, Daniel - Student on 3/1/23.
//

import UIKit

protocol OfferCellProtocol: AnyObject {
    func expandButtonPressedAt(indexPath: IndexPath)
    func webButtonPressedAt(indexPath: IndexPath, url: String)
}

class OfferCell: UITableViewCell {
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var expandButton: UIButton!
    @IBOutlet weak var offerLabel: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!

    weak var delegate: OfferCellProtocol?
    var offer = Offer(name: "", details: [], logoURL: nil, location: [], buttons: [])
    var isExpanded: Bool = false
    var indexPath = IndexPath()

    @objc func webButtonPressed() {
        self.delegate?.webButtonPressedAt(indexPath: self.indexPath, url: offer.buttons[0].url)
    }

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
        button1.addTarget(self, action: #selector(webButtonPressed), for: .touchUpInside)
        button2.addTarget(self, action: #selector(webButtonPressed), for: .touchUpInside)
        button3.addTarget(self, action: #selector(webButtonPressed), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func config(offer: Offer, isExpanded: Bool, indexPath: IndexPath, delegate: OfferCellProtocol) {
        self.offer = offer
        name.text = offer.name
        logo.image = offer.logoImg
        offerLabel.text = offer.details.first
        
        button1.setTitle("N/A", for: .normal)
        button1.isHidden = true
        button2.setTitle("N/A", for: .normal)
        button2.isHidden = true
        button3.setTitle("N/A", for: .normal)
        button3.isHidden = true

        let buttonCount = offer.buttons.count

        if buttonCount > 0 {
            button1.setTitle(offer.buttons[0].showName, for: .normal)
            button1.isHidden = false
        }
        if buttonCount > 1 {
            button2.setTitle(offer.buttons[1].showName, for: .normal)
            button2.isHidden = false
        }
        if buttonCount > 2 {
            button3.setTitle(offer.buttons[2].showName, for: .normal)
            button3.isHidden = false
        }

        self.isExpanded = isExpanded
        self.indexPath = indexPath
        self.delegate = delegate


        expandButton.transform = CGAffineTransformMakeRotation(isExpanded ? .pi * 0.5 : 0)
    }
}
