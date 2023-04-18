//
//  InfoCell.swift
//  PSDOffers
//
//  Created by Laviolette, Akivah - Student on 4/18/23.
//

import UIKit

class InfoCell: UITableViewCell {

    @IBOutlet weak var infoLabel: UILabel!
    
    func configure(label: String) {
        infoLabel.text = label
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
