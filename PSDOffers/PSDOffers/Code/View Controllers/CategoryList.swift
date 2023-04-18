//
//  CategoryList.swift
//  PSDOffers
//
//  Created by Laviolette, Akivah - Student on 4/11/23.
//

import UIKit

enum Category: String, CaseIterable { case all, finance, food, health, retail, technology}

extension Category {
    var title: String {
        switch self {
        case .all: return "All Offers"
        default:
            return "\(self)".capitalizingFirstLetter()
        }
    }
}

extension Category: Codable {
    
}

protocol CategoryListProtocol: AnyObject {
    func categorySelected(category: Category)
}

class CategoryList: UITableViewController {

    var selectedCategory = Category.all
    
    weak var delegate: CategoryListProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Category.allCases.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as? CategoryCell {
            
            // Configure the cell...
            let category = Category.allCases[indexPath.row]
            cell.title.text =  category.title
            cell.check.isHidden = category != selectedCategory
            
            return cell
        }
        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let next = Category.allCases[indexPath.row]
      //  if let next = Category(rawValue: indexPath.row) {
            selectedCategory = next
            delegate?.categorySelected(category: next)
            self.dismiss(animated: true)
           // tableView.reloadData()
     //   }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
