//
//  ArchivedItemsTableViewController.swift
//  
//
//  Created by Gary O'Donoghue on 20/01/2019.
//

import UIKit

class ArchivedItemsViewController: UIViewController {

    @IBOutlet weak var comicTitle: UILabel!
    @IBOutlet weak var comicImage: UIImageView!
    
    let dataAccess = ArchivedDataAccess()
    let commonDataAccess = CommonDataAccess()
    
    var comics: [Comic]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        dataAccess.getArchived(completion: { result in
            self.comics = result
            if let firstComic = self.comics?[0] {
                self.comicTitle.text = firstComic.title
                
                self.commonDataAccess.getImage(byUrl: firstComic.imageUrl, completion: { data in
                    self.comicImage?.image = UIImage(data: data)
                })
            }
        })
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeLeft
    }

    override var shouldAutorotate: Bool {
        return true
    }
}
