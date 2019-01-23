//
//  MainViewController.swift
//  chuckthemonk
//
//  Created by Gary O'Donoghue on 23/01/2019.
//  Copyright © 2019 Gary O'Donoghue. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var archivedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    

    @IBAction func unwindToMainMenu(segue:UIStoryboardSegue) { }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
}
