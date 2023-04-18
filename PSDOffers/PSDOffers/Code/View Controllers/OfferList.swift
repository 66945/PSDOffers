//
//  OfferList.swift
//  PSDOffers
//
//  Created by McGrath, Daniel - Student on 3/1/23.
//

import UIKit
import SafariServices
import MessageUI

class OfferList: UITableViewController {
    
    var isExpanded: [Bool] = Array(repeating: false, count: Offer.offers.count)
    var useCompact = false

    @IBAction func listModeChanged(_ sender: UISegmentedControl) {
        useCompact = sender.selectedSegmentIndex == 1
        isExpanded = Array(repeating: false, count: Offer.offers.count)
        tableView.reloadData()
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "OfferCell", bundle: nil), forCellReuseIdentifier: "OfferCell")
        tableView.register(UINib(nibName: "CompactOfferCell", bundle: nil), forCellReuseIdentifier: "CompactOfferCell")

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
        let useHeight = useCompact ? 44.0 : 124.0
        return isExpanded[indexPath.row] ? UITableView.automaticDimension : useHeight
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellName = useCompact ? "CompactOfferCell" : "OfferCell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as? OfferCell {
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

extension OfferList: MFMailComposeViewControllerDelegate {
    func sendEmail(address: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([address])
            mail.setMessageBody("<p></p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            // show failure alert
            let alert = UIAlertController(title: "Unable to send mail", message: "Check internet connection.", preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

extension OfferList: OfferCellProtocol {
    func emailButtonPressedAt(indexPath: IndexPath, address: String) {
        sendEmail(address: address)
    }
    
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