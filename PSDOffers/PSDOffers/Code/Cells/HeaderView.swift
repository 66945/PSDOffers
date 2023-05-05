//
//  HeaderTableViewCell.swift
//  PSDOffers
//
//  Created by Laviolette, Akivah - Student on 4/28/23.
//

import UIKit



// Protocol for telling when button is tapped

protocol HeaderViewProtocol: AnyObject {
    
    func headerTapped()
    
}



class HeaderView: UIView {
    
    
    
    @IBOutlet weak var button: UIButton!    // Be sure to connect to button in view
    
    
    
    weak var delegate: HeaderViewProtocol?
    
    
    
    func configure(title: String, delegate: HeaderViewProtocol) {
        
        button.setTitle(title, for: .normal)
        
        self.delegate = delegate
        
    }
    
    
    
    @objc func headerTapped() {
        
        delegate?.headerTapped()
        
    }
    
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        button.addTarget(self, action: #selector(headerTapped), for: .touchUpInside)
        
    }
    
}

