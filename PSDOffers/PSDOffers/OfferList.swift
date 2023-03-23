//
//  OfferList.swift
//  PSDOffers
//
//  Created by McGrath, Daniel - Student on 3/1/23.
//

import UIKit
import SafariServices

class OfferList: UITableViewController {

    var isExpanded: [Bool] = Array(repeating: false, count: Offer.offers.count)

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "OfferCell", bundle: nil), forCellReuseIdentifier: "OfferCell")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        let imgview = UIImageView(image: UIImage(named: "psdLogo"))
        imgview.contentMode = .scaleAspectFit
            navigationItem.titleView = imgview
        
        
        if let json = Offer.offers.json {
            if let s = String.init(data: json, encoding: .utf8) {
                print(s)
            }
        }
        Offer.loadOffers()
        isExpanded = Array(repeating: false, count: Offer.offers.count)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Offer.offers.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return isExpanded[indexPath.row] ? UITableView.automaticDimension : 115
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "OfferCell", for: indexPath) as? OfferCell {
            cell.config(offer: Offer.offers[indexPath.row],
                        isExpanded: isExpanded[indexPath.row],
                        indexPath: indexPath,
                        delegate: self)
            return cell
        }

        return UITableViewCell()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? WebViewController, let urlString = sender as? String {
            if let url = URL(string: urlString) {
                vc.configure(url: url)
            }
        }
    }
}

extension OfferList: OfferCellProtocol {
    func webButtonPressedAt(indexPath: IndexPath, url: String) {
        if let realUrl = URL(string: url) {
            let svc = SFSafariViewController(url: realUrl)
            present(svc, animated: true)
        }
    }
    
    func expandButtonPressedAt(indexPath: IndexPath) {
        let row = indexPath.row
        isExpanded[row] = !isExpanded[row]
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

}
