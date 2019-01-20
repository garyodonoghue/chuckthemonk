//
//  ArchivedItemsTableViewController.swift
//  
//
//  Created by Gary O'Donoghue on 20/01/2019.
//

import UIKit

class ArchivedItemsTableViewController: UITableViewController {

    let dataAccess = ArchivedDataAccess()
    var comics: [Comic]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(ArchivedRowTableViewCell.self, forCellReuseIdentifier: "ArchivedRow")
    
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
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "ArchivedRow", for: indexPath) as! ArchivedRowTableViewCell
        
        if let comic = self.comics?[indexPath.row] {
            cell.setupCell(withTitle: comic.title, andImageUrl: comic.imageUrl)
        }
        
        return cell
    }
}

class ArchivedRowTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var comicTitle: UITextField!
    @IBOutlet weak var comicContent: UIImageView!
    
    let dataAccessLayer = CommonDataAccess()
    
    public func setupCell(withTitle title: String, andImageUrl imageUrl: String){
        self.comicTitle.text = title
        dataAccessLayer.getImage(byUrl: imageUrl, completion: { data in
            self.comicContent.image = UIImage(data: data)
        })
    }
}
