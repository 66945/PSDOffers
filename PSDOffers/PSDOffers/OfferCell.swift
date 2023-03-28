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
    func emailButtonPressedAt(indexPath: IndexPath, address: String)
}

class OfferCell: UITableViewCell {
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var expandButton: UIButton!
    @IBOutlet weak var offerLabel: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var emailButton1: UIButton!
    @IBOutlet weak var emailButton2: UIButton!
    @IBOutlet weak var emailButton3: UIButton!

    

    weak var delegate: OfferCellProtocol?
    var offer = Offer(name: "", details: [], logoURL: nil, location: [], buttons: [], emailButtons: [])
    var isExpanded: Bool = false
    var indexPath = IndexPath()
    
    @objc func webButtonPressed(sender: UIButton) {
        let index = sender.tag
        self.delegate?.webButtonPressedAt(indexPath: self.indexPath, url: offer.buttons[index].url)
    }
    
    @objc func emailButtonPressed(sender: UIButton) {
        let index = sender.tag
        self.delegate?.webButtonPressedAt(indexPath: self.indexPath, url: offer.emailButtons[index].address)
        
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
        
        let buttons = [button1, button2, button3]
        for (index, button) in buttons.enumerated() {
            button?.addTarget(self, action: #selector(webButtonPressed), for: .touchUpInside)
            button?.tag = index
        }
        
        let eButtons = [emailButton1, emailButton2, emailButton3]
        for (index, button) in buttons.enumerated() {
            button?.addTarget(self, action: #selector(emailButtonPressed), for: .touchUpInside)
            button?.tag = index
        }
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
        
        emailButton1.setTitle("N/A", for: .normal)
        emailButton1.isHidden = true
        emailButton2.setTitle("N/A", for: .normal)
        emailButton2.isHidden = true
        emailButton3.setTitle("N/A", for: .normal)
        emailButton3.isHidden = true
        
        
        let eButtonCount = offer.emailButtons.count
        
        if eButtonCount > 0 {
            emailButton1.setTitle(offer.emailButtons[0].address, for: .normal)
            emailButton1.isHidden = false
        }
        if eButtonCount > 1 {
            emailButton2.setTitle(offer.emailButtons[1].address, for: .normal)
            emailButton2.isHidden = false
        }
        if eButtonCount > 2 {
            emailButton3.setTitle(offer.emailButtons[2].address, for: .normal)
            emailButton3.isHidden = false
        }
   // offerLabel.text = offer.details.first
        self.isExpanded = isExpanded
        self.indexPath = indexPath
        self.delegate = delegate
        

        expandButton.transform = CGAffineTransformMakeRotation(isExpanded ? .pi * 0.5 : 0)
    }
}
