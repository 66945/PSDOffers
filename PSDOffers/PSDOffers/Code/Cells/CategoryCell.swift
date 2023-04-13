//
//  CategoryCell.swift
//  PSDOffers
//
//  Created by Laviolette, Akivah - Student on 4/11/23.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    @IBOutlet weak var check: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
