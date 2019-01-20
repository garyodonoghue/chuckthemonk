//
//  ArchivedItemsTableViewController.swift
//  
//
//  Created by Gary O'Donoghue on 20/01/2019.
//

import UIKit

class ArchivedItemsTableViewController: UITableViewController {

    let dataAccess = DataAccessLayer()
    var comics: [Comic]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataAccess.getArchived(completion: { result in
            self.comics = result
            self.tableView.reloadData()
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let count = self.comics?.count {
            return count
        } else {
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArchivedRow", for: indexPath)

        if let comic = self.comics?[indexPath.row] {
            cell.textLabel?.text = comic.title
        }
        
        return cell
    }
}
