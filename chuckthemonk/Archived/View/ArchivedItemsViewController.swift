//
//  ArchivedItemsTableViewController.swift
//  
//
//  Created by Gary O'Donoghue on 20/01/2019.
//

import UIKit

class ArchivedItemsViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    private let dataAccess = DataAccess()
    private var index = 0
    private var filledIndex = 0
    private var comics: [Comic]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        scrollView.delegate = self
        
        dataAccess.getArchived(completion: { comicMetadata in
            self.comics = comicMetadata
            self.setupScrollView()
            self.updateComicsScrollView(comics: self.createComics())
        })
    }
    
    private func setupScrollView(){
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * 5, height: view.frame.height)
        scrollView.isPagingEnabled = true
    }
    
    // lazy load comic images 5 at a time
    func createComics() -> [ComicView] {
        var comicsArray : [ComicView] = []
        
        for i in index ..< index+5 {
            let comicInstance: ComicView = Bundle.main.loadNibNamed("ComicView", owner: self, options: nil)?.first as! ComicView
            
            guard let title = comicInstance.comicTitle else { break }
            title.text = self.comics![i].title
            self.dataAccess.getImage(byUrl: self.comics![i].imageUrl, completion: { data in
                    comicInstance.comicImage.image = UIImage(data: data)
                    comicInstance.activityIndicator.stopAnimating()
                })
            
            comicsArray.append(comicInstance)
        }
        
        return comicsArray
    }
    
    // Add the 5 subviews (one for each comic) to the scrollview
    func updateComicsScrollView(comics : [ComicView]) {
        for comic in comics {
            comic.frame = CGRect(x: view.frame.width * CGFloat(self.filledIndex), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(comic)
            self.filledIndex = self.filledIndex+1
        }
        
        scrollView.contentSize = CGSize(width: CGFloat(view.frame.width) * CGFloat(self.filledIndex), height: view.frame.height)
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeLeft
    }

    override var shouldAutorotate: Bool {
        return true
    }
    
    //when the user lifts their finger
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        self.index = self.index+1
        if(self.index % 5 == 0){
            self.updateComicsScrollView(comics: self.createComics())
        }
    }
}
